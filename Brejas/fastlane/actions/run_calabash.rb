module Fastlane
    module Actions
        module SharedValues
            RUN_CALABASH_CUSTOM_VALUE = :RUN_CALABASH_CUSTOM_VALUE
        end

        class RunCalabashAction < Action
            def self.run(params)
                ################################################################
                # Autor: Mateus de Campos                                      #
                # Contribuidores: Matheus Feola, Wesley Silva                  #
                # Data: 11/10/2016 V1                                          #
                #                                                              #
                # Objetivo: Esse programa tem como objetivo rodar as especifi- #
                # cações escritas pelo QA utiliando o cucamber                 #
                #                                                              #
                # Exemplo: Recebe como parametro a URL do repositório de,      #
                # specs para que possa ser clonado, URL para o arquivo .app do #
                # projeto que será testado e o parametro de reinstall, que diz #
                # se o app tem que ser reinstalado no simulador toda vez.      #
                #                                                              #
                # Passo a passo: Pega o id do simulador instalado no computa-  #
                # dor, clona o repositório de specs e instala as gems necessá- #
                # rias atraves do bundle install, roda as specs e copia os re- #
                # latórios para a pasta do app.                                #
                ################################################################

                # Coletando parâmetros
                UI.message "Parameter specs_repository: #{params[:specs_repository]}"
                UI.message "Parameter app_path: #{params[:app_path]}"
                UI.message "Parameter reinstall: #{params[:reinstall]}"

                # Preenchendo variáveis para a execução
                temp_folder = 'temp_calabash_folder'
                specs_repository = (params[:specs_repository]).to_s.strip
                app_path = (params[:app_path]).to_s.strip
                simulator = sh "xcrun simctl list devices | \
                grep 'iPhone 6' | \
                grep Shutdown | \
                egrep -v 'unavailable|iPhone 6s Plus|iPhone 6s|iPhone 6 Plus' | \
                cut -d'(' -f2 | \
                cut -d')' -f1 | \
                tail -1" # lista os simuladores e filtra para pegar o iPhone 6
                reinstall = (params[:reinstall]).to_i
                dir_name = File.dirname(app_path.to_s)

                # Apaga temp folder caso exista
                FileUtils.rm_r temp_folder if Dir.exist?(temp_folder)

                # Script que fará o clone do repositório e a execução das specs
                calabash_program = <<-EOF
                git clone '#{specs_repository}' --branch dev '#{temp_folder}'
                cd $(pwd)/'#{temp_folder}'
                bundle install
                cucumber -p ios --format html --out reports.html \
                APP_BUNDLE_PATH=#{app_path} \
                DEVICE_TARGET=#{simulator} \
                RESET_BETWEEN_SCENARIOS=#{reinstall}
                EOF

                # Executa o script com uma instancia limpa do bundler para não
                # interfirir nas gems do projeto
                Bundler.with_clean_env do
                    `#{calabash_program}`
                end

                # Copia os relatorios para a pasta do app
                sh "cp $(pwd)/'#{temp_folder}'/reports.html #{dir_name}
                cp -r $(pwd)/'#{temp_folder}'/screenshots #{dir_name}"

                # Apaga temp folder caso exista
                FileUtils.rm_r temp_folder if Dir.exist?(temp_folder)

                puts('Thanks for using')
            end

            #####################################################
            # @!group Documentation
            #####################################################

            def self.description
                'A short description with <= 80 characters of what this action does'
            end

            def self.details
                # Optional:
                # this is your chance to provide a more detailed description of this action
                'You can use this action to do cool things...'
            end

            def self.available_options
                # Define all options your action supports.

                # Below a few examples
                [
                    FastlaneCore::ConfigItem.new(key: :specs_repository,
                                                 env_name: 'FL_RUN_CALABASH_SPECS_REPOSITORY', # The name of the environment variable
                                                 description: 'specs_repository for RunCalabashAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No specs_repository for RunCalabashAction given, pass using `specs_repository: 'specs_repository'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end),
                    FastlaneCore::ConfigItem.new(key: :app_path,
                                                 env_name: 'FL_RUN_CALABASH_APP_PATH', # The name of the environment variable
                                                 description: 'app_path for RunCalabashAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No app_path for RunCalabashAction given, pass using `app_path: 'app_path'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end),
                    FastlaneCore::ConfigItem.new(key: :reinstall,
                                                 env_name: 'FL_RUN_CALABASH_REINSTALL', # The name of the environment variable
                                                 description: 'reinstall for RunCalabashAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No reinstall for RunCalabashAction given, pass using `reinstall: 'reinstall'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end)
                ]
            end

            def self.output
                # Define the shared values you are going to provide
                # Example
                [
                    ['RUN_CALABASH_CUSTOM_VALUE', 'A description of what this value contains']
                ]
            end

            def self.return_value
                # If you method provides a return value, you can describe here what it does
            end

            def self.authors
                # So no one will ever forget your contribution to fastlane :) You are awesome btw!
                ['Mateus de Campos']
            end

            def self.is_supported?(platform)
                # you can do things like
                #
                #  true
                #
                #  platform == :ios
                #
                #  [:ios, :mac].include?(platform)
                #

                platform == :ios
            end
        end
    end
end
