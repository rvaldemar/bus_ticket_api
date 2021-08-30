class TicketController < ApplicationController
  respond_to :json

  def_param_group :tickets do
    property :id, Integer
    property :seat_number, Integer, desc: "Number of seat on bus. "
    property :status, String, desc: "One of 'processing', 'processed' or 'processing'. "
    property :bus_number, Integer, desc: "Number of the bus. "
    property :departure_time, String, desc: "Time of departure. "
    property :arrival_time, String, desc: "Time of arrival. "
    property :starting_point, String, desc: "Starting city name. "
    property :destination, String, desc: "Destination city name. "
  end

  api :PUT, '/buy/:id', 'Buy ticket end point'
  api :POST, '/buy/:id', 'Buy ticket end point'
  param :id, Integer, required: true, desc: 'Trip id, provided by search method. '
  param :payment_details, Hash, desc: 'Payment details in format that is accepted by the financial department. ', required: true

  returns array_of: :tickets, desc: "Array of tickets for all subset of routes within the main trip. "
  def buy
    now = Time.now
    @tickets = []
    routes = params[:route_id].split('_').map { |id| Route.find(id) }

    if routes.first.start_date - now < 30 * 60
      return error(:not_found, 403, 'It is not possible to buy tickets 30 minutes before departure ')
    end

    unless routes.all?(&:seats_available?)
      return error(:not_found, 403, 'There are no available tickets for the this route ')
    end

    ActiveRecord::Base.transaction do
      routes.each do |route|
        route_tickets = route.tickets.where.not(status: 'processing')
        seat_number = route_tickets.count.blank? ? 1 :
          (1..(route_tickets.count + 1)).find { |n| !route_tickets.pluck(:seat_number).include?(n) }

        @tickets.push Ticket.create!(
          seat_number: seat_number,
          route_id: route.id,
          status: 'processing',
          payment_details: params['payment_details']
        )
      end
    end

    render :index
  end

  api :PUT, '/cancel/:id', 'Return ticket'
  api :POST, '/cancel/:id', 'Return ticket'
  param :id, Integer, required: true, desc: 'Ticket id. '

  returns({http_status: "200", message: "Ticket canceled successfully. Your payment will be returned soon. " })
  def cancel
    @ticket = Ticket.find(params[:id])
    now = Time.now

    if @ticket.route.start_date - now < 30 * 60
      return error(:not_found, 403, 'It is not possible to cancel the ticket 30 minutes before departure ')
    end

    @ticket.update!(status: 'canceled')

    render json: { http_status: "200", message: "Ticket canceled successfully. Your payment will be returned soon. " }
  end
end
