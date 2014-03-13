class SponsorshipsController < ApplicationController
	before_filter :authenticate_admin_user!
	before_filter :find_sponsorship

	def confirm
		if @sponsorship.confirm!
			flash[:notice] = "confirmed sponsorship"
		else
			flash[:error] = "failed to confirm sponsorship"
		end

    redirect_to admin_artifact_path(@sponsorship.artifact)
	end

	def unconfirm
		if @sponsorship.unconfirm!
			flash[:notice] = "Unconfirmed sponsorship"
		else
			flash[:error] = "Faild to unconfirm sponsorship"
		end

    redirect_to admin_artifact_path(@sponsorship.artifact)
	end

	def find_sponsorship
		@sponsorship = Sponsorship.find(params[:id])
	end
end
