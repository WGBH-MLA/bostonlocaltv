class DigitizationsController < ApplicationController

	def create
		artifact = Artifact.find_or_create_by_solr_document_id(params[:id])
		if artifact.request_digitization(current_user)
			flash[:notice] = 'request successfully made'
		else
		  flash[:error] = 'failure'
		end
		redirect_to catalog_path(params[:id])
	end

	def destroy
		artifact = current_user.artifacts.find(params[:id])
		if artifact.withdraw_request(current_user)
			flash[:notice] = 'request withdrawn'
		else
		  flash[:error] = 'failure'
		end
		redirect_to dashboard_path
	end

end