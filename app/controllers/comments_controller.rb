class CommentsController < ApplicationController
  def create
    @iniciativa = Initiative.find(params[:iniciativa_id])

    message = if params[:other_email].blank? && @iniciativa.comments.create_approved(params[:comment])
        {:notice => "Comentario creado exitosamente"}
      else
        {:alert => "Comentario fallo al crearse"}
      end
    redirect_to :back, message
  end
end
