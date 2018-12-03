class IndexController < ApplicationController
    layout :resolve_layout

private

def resolve_layout
  "inicio"
end
  def inicio
    @user=User.new
    @edu=Education.new
    @total=User.all.size
    @universitarios=@edu.universitarios
    @titulados=@edu.titulados
    @empresas=@user.empresas
  end
end
