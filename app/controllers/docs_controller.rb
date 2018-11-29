class DocsController < ApplicationController
    before_action :find_doc, only: [:show, :edit, :update, :destroy]

    def index
        @docs = Doc.where(user_id: current_user)
    end

    def show
    end

    def new
        @doc = Doc.new
    end

    def create
        @doc = current_user.docs.new(doc_params)

        respond_to do |format|
            if @doc.save
              format.html { redirect_to @doc, warning: 'Documento Creado Exitosamente.' }
              format.json { render :show, status: :created, location: @doc }
            else
              format.html { render :new }
              format.json { render json: @doc.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
    end

    def update
    end

    def update
        respond_to do |format|
            if @doc.update(doc_params)
              format.html { redirect_to @doc, warning: 'Documento Editado Exitosamente.' }
              format.json { render :show, status: :ok, location: @doc }
            else
              format.html { render :edit }
              format.json { render json: @doc.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @doc.destroy
        respond_to do |format|
            format.html { redirect_to docs_url, warning: 'Documento Borrado Exitosamente.' }
            format.json { head :no_content }
        end
    end

    private
        def find_doc
            @doc = Doc.find(params[:id])
        end

        def doc_params
            params.require(:doc).permit(:title, :content)
        end
end
