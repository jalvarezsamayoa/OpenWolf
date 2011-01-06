# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe Usuario do
  
  before(:each) do
    @usuario = Factory(:usuario)
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:nombre) }
  it { should validate_presence_of(:cargo) }
  it { should validate_presence_of(:institucion_id) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:nombre) }
  
  it { should belong_to(:institucion) }
  it { should have_and_belong_to_many(:roles) }
  it { should have_many(:actividades) }
  it { should have_many(:solicitudes) }
  it { should have_many(:documentos) }
  
  it "debe ser valido" do
    @usuario.should be_valid
  end
  
  describe '#nombre_cargo' do    
    it 'conbina nombre mas cargo del usuario' do
      @usuario.nombre = 'Nombre Usuario'
      @usuario.cargo = 'Cargo'
      @usuario.nombre_cargo.should == 'Nombre Usuario, Cargo'
    end
  end

  describe '#nombre_institucion' do    
    it 'conbina nombre mas nombre institucion' do
      @usuario.nombre = 'Nombre Usuario'
      nombre_institucion = @usuario.institucion.nombre
      resultado = 'Nombre Usuario en ' + nombre_institucion
      @usuario.nombre_institucion.should == resultado
    end    
  end

  describe 'Cambio de contraseña' do    
    it 'debe cambiar al proporcionar pwd y confirmacion' do
      @usuario.password = 'abcdef'
      @usuario.password_confirmation = 'abcdef'
      @usuario.should be_valid
    end

    it "no debe cambiar pwd si no coinciden valores" do
      @usuario.password = 'abcdef'
      @usuario.password_confirmation = 'aaabbb'
      @usuario.should_not be_valid
    end    
  end

  describe 'Registro de cambios' do
    it "debe tener version 1 al ser nuevo" do
      @usuario.version.should == 1
    end
    
    it "debe de generar registro en el log si hay cambio en los campos" do
#      @usuario.nombre = "Nuevo Nombre"
      @usuario.nombre = "Nuevo nombre"
      @usuario.save!
      @usuario.version.should == 2
    end    
  end

  describe 'Notificacion de nueva cuenta de usuario' do
    pending
  end

end
