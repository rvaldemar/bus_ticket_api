class RoutesController < ApplicationController
  def search
    attrs = search_params
    attrs[end_date] = params[:end_date] ?
      params[:end_date] || search_params[:start_date].to_datetime.at_end_of_day

    Route.where(start_point_params)
  end

  private
  def start_point_params
    params.permit(
      :start_date,
      :start_id,
    )
  end
end
