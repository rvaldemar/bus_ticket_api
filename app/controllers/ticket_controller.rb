class TicketController < ApplicationController
  respond_to :json

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
        route_tickets = route.tickets.where.not(status: 'canceled')
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
