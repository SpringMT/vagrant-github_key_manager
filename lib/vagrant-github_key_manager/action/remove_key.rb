module VagrantPlugins
  module GithubKeyManager
    module Action
      class RemoveKey
        def initialize(app, env)
          @app = app
          @ui = env[:ui]
          @machine = env[:machine]
        end

        def call(env)
          @ui.info("not yet implemented")
          @app.call(env)
        end

      end
    end
  end
end 


