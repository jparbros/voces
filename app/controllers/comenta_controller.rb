class ComentaController < ApplicationController

  def show
    @comentario = Comment.new
    @comentarios = Comment.order("created_at DESC").all
  end

  def create
    if params[:other_email].blank?
      message = Comment.create_approved(params[:comment]) ? {:notice => 'Comentario se creo.'} : {:error => 'Error al crear el comentario.'}
    end
    redirect_to :back, message ||= {:error => 'Error al crear el comentario.'}
  end
end
