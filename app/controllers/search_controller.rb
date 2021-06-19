class SearchController < ApplicationController
  def redirect
    puts request.inspect
    unless params[:query].blank?
      case params[:search_in]
      when 'projects' then redirect_to projects_path(query: params[:query]) and return
      when 'contacts' then redirect_to contacts_path(query: params[:query]) and return
      when 'deadlines' then redirect_to deadlines_path(query: params[:query]) and return
      end
    end
    redirect_to projects_url # Note: I could have used redirect_back, but sadly it does not give enough control over the params (i.e. I wanted to clear them)
  end
end
