# -*- coding: utf-8 -*-
class RecursosrevisionController < ApplicationController
  before_filter :get_solicitud

  access_control do
    allow :superudip
    allow :userudip
  end

  def index
    @recursosrevision = @solicitud.recursosrevision
  end
    
  # GET /recursosrevision/1
  # GET /recursosrevision/1.xml
  def show
    @recursorevision = @solicitud.recursosrevision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /recursosrevision/new
  # GET /recursosrevision/new.xml
  def new
    @recursorevision = @solicitud.recursosrevision.new    
    @recursorevision.solicitud_id = @solicitud.id
    @recursorevision.institucion_id = @solicitud.institucion_id
    @recursorevision.usuario_id = usuario_actual.id
    @recursorevision.descripcion = 'No Disponible'
    @recursorevision.numero = @recursorevision.nuevo_numero
    @recursorevision.fecha_presentacion = l(Date.today)
    @recursorevision.fecha_notificacion = l(Date.today)
    @recursorevision.fecha_resolucion = l(Date.today)
    
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end

  # GET /recursosrevision/1/edit
  def edit
    @recursorevision = @solicitud.recursosrevision.find(params[:id])
  end

  # POST /recursosrevision
  # POST /recursosrevision.xml
  def create
    @recursorevision = @solicitud.recursosrevision.new(params[:recursorevision])
    @recursorevision.institucion_id = current_user.institucion_id
    @recursorevision.solicitud_id = @solicitud.id
    @recursorevision.usuario_id = current_user.id

    #limpiamos fecha pasandola a formato MM/DD/YYYY
    @recursorevision.fecha_presentacion = fix_date(params[:recursorevision][:fecha_presentacion])

    respond_to do |format|
      if @recursorevision.save
        format.html { redirect_to([@solicitud, @recursorevision], :notice => 'Recurso revision creado con exito.') }
        format.xml  { render :xml => @recursorevision, :status => :created, :location => @recursorevision }
      else
        logger.debug { "Error: #{@recursorevision.errors}" }
        flash[:error] = 'No fue posible generar el recurso de revisión.'
        format.html { render :action => 'new' } 
        format.xml  { render :xml => @recursorevision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recursosrevision/1
  # PUT /recursosrevision/1.xml
  def update
    @recursorevision = @solicitud.recursosrevision.find(params[:id])

    respond_to do |format|
      if @recursorevision.update_attributes(params[:recursorevision])
        format.html { redirect_to([@solicitud,@recursorevision], :notice => 'Recurso revisión actualizado con exito.') }
        format.xml  { head :ok }
      else        
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recursorevision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recursosrevision/1
  # DELETE /recursosrevision/1.xml
  def destroy
    @recursorevision = @solicitud.recursosrevision.find(params[:id])
    @recursorevision.destroy

    respond_to do |format|
      format.html { redirect_to(solicitud_recursosrevision_url(@solicitud), :notice => "Recurso de revisión eliminado con exito.") }
      format.xml  { head :ok }
    end
  end

  def get_solicitud
    #TODO: filtrar por institucion
    @solicitud = Solicitud.find(params[:solicitud_id])   
  end
end
