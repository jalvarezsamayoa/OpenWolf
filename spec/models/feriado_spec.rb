require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feriado do

  def primer_dia_semana
    (Date.today.wday - 1).days.ago.to_date
  end

  def segundo_dia_semana
    primer_dia_semana + 1
  end

  def sabado_anterior
    primer_dia_semana - 2
  end

  def domingo_anterior
    primer_dia_semana - 1
  end

  def viernes_anterior
    primer_dia_semana - 3
  end

  def sabado_siguiente
    primer_dia_semana + 5
  end

  def hay_feriado_el(fecha_feriado)
    feriado = Factory.build(:feriado)
    feriado.dia = fecha_feriado.day
    feriado.mes = fecha_feriado.month
    feriado.fecha = fecha_feriado
    feriado.save
  end

  before(:each) do
    @feriado = Factory :feriado
  end

  it "debe ser valido" do
    @feriado.should be_valid
  end

  describe '#por_institucion' do
    it 'retorna feriados que pertenecen a la institucion' do
      @feriado.save
      Feriado.por_institucion(@feriado.institucion_id).should have(1).record
    end
  end

  describe '#en_fecha' do
    it 'retorna feriados que coincidan en dia y mes' do
      @feriado.save
      Feriado.en_fecha(@feriado.fecha).should have(1).record
    end
  end

  describe '.hay_feriado?' do

    it 'debe regresar false si no hay parametros' do
      Feriado.hay_feriado?(nil).should == false
    end

    it "deber regresar true si la fecha coincide con un feriado" do
      feriado = mock_model(Feriado)
      Feriado.stub_chain(:por_institucion,:en_fecha,:limit).and_return([feriado])
      Feriado.hay_feriado?.should == true
    end

    it "deber regresar false si no coincide con un feriado" do
      Feriado.stub_chain(:por_institucion,:en_fecha,:limit).and_return([])
      Feriado.hay_feriado?.should == false
    end

  end

  describe '.obtener_fecha_valida' do

    context 'si no hay feriados' do
      it 'regresa la misma fecha dada si fecha es dia laboral' do
        fecha_entrega = primer_dia_semana() # lunes
        Feriado.obtener_fecha_valida(fecha_entrega, Institucion::ESTADO_GUATEMALA).should == fecha_entrega
      end

      it "regresa la fecha del lunes siguiente si fecha es fin de semana" do
        fecha_entrega = sabado_anterior()
        Feriado.obtener_fecha_valida(fecha_entrega, Institucion::ESTADO_GUATEMALA).should == primer_dia_semana

        fecha_entrega = domingo_anterior()
        Feriado.obtener_fecha_valida(fecha_entrega, Institucion::ESTADO_GUATEMALA).should == primer_dia_semana

      end
    end

    context 'si hay feriados' do

      it "regresa el siguiente dia laboral si la fecha coincide con el feriado" do
        fecha_feriado = primer_dia_semana
        hay_feriado_el(fecha_feriado)
        Feriado.obtener_fecha_valida(fecha_feriado, Institucion::ESTADO_GUATEMALA).should == (fecha_feriado + 1)
      end

      it "regresa el lunes siguiente si el feriado coincide con un viernes" do
        hay_feriado_el(viernes_anterior)
        Feriado.obtener_fecha_valida(viernes_anterior, Institucion::ESTADO_GUATEMALA).should == primer_dia_semana
      end

      it "regresa el siguiente dia laboral cuando hay multiples feriados corridos" do
        hay_feriado_el(viernes_anterior)
        hay_feriado_el(primer_dia_semana)

        Feriado.obtener_fecha_valida(viernes_anterior, Institucion::ESTADO_GUATEMALA).should == segundo_dia_semana

      end

    end

  end


  describe '#es_dia_laboral?' do
    it 'regresa false si es domingo o sabado' do
      @feriado.es_dia_laboral?(domingo_anterior).should == false
      @feriado.es_dia_laboral?(sabado_anterior).should == false
    end

    it "regresa true si es dia laboral" do
      @feriado.es_dia_laboral?(primer_dia_semana).should == true
    end
  end

  describe '.calcular_dias_no_laborales' do
    
    context 'cuando no hay feriados' do
      it 'retorna el numero de sabados y domingos en el rango de dias dado' do
        Feriado.stub!(:hay_feriado?).and_return(false)
        
        Feriado.calcular_dias_no_laborales(:fecha => primer_dia_semana,
                                           :dias => 10).should == 2

        Feriado.calcular_dias_no_laborales(:fecha => viernes_anterior,
                                           :dias => 10).should == 4

      end
    end

    context 'cuando hay feriado' do
      it "retorna el numero de sabados y domingos mas el numero de feriados" do
        hay_feriado_el(segundo_dia_semana)
        
        Feriado.calcular_dias_no_laborales(:fecha => primer_dia_semana,
                                           :dias => 10).should == 3

        Feriado.calcular_dias_no_laborales(:fecha => viernes_anterior,
                                           :dias => 10).should == 5
      end

      it "no toma en cuenta el feriado si el feriado es el fin de semana" do
        hay_feriado_el(sabado_siguiente)
        
        Feriado.calcular_dias_no_laborales(:fecha => primer_dia_semana,
                                           :dias => 10).should == 2

        Feriado.calcular_dias_no_laborales(:fecha => viernes_anterior,
                                           :dias => 10).should == 4
      end
    
    end
    
  end

end

