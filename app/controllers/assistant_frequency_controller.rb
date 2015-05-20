class AssistantFrequencyController < ApplicationController
  def create
  end

  def destroy
  end

   # GET /assistant_frequency
  def index

  end

  def request_frequency
	deubom = true
	respond_to do |format|
		if deubom
		  format.html { redirect_to '/assistant_frequency/', notice: 'Pedidos enviados com sucesso.' }
		else
		  format.html { redirect_to '/assistant_frequency/', alert: 'Houve algum problema no envio dos pedidos.' }
		end
	end
  	print ">>> OI <<<\n"
  end

end
