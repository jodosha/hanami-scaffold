# frozen_string_literal: true

require "shellwords"
require "hanami/utils/string"
require "hanami/cli/commands"

module Hanami
  module Scaffold
    module CLI
      class Command < Hanami::CLI::Commands::Command
        desc "Generate scaffold"

        argument :app,   desc: "The app name"
        argument :model, desc: "The model name"

        # rubocop:disable Metrics/MethodLength
        def call(app:, model:, **)
          app      = Shellwords.escape(app)
          singular = Shellwords.escape(model)
          plural   = Utils::String.pluralize(singular)

          system "bundle exec hanami generate model #{singular}"

          system %(bundle exec hanami generate action #{app} #{plural}#index --url="/#{plural}")
          system %(bundle exec hanami generate action #{app} #{plural}#show --url="/#{plural}")
          system %(bundle exec hanami generate action #{app} #{plural}#new --url="/#{plural}/new")
          system %(bundle exec hanami generate action #{app} #{plural}#create --url="/#{plural}")
          system %(bundle exec hanami generate action #{app} #{plural}#edit --url="/#{plural}/edit")
          system %(bundle exec hanami generate action #{app} #{plural}#update --url="/#{plural}")
          system %(bundle exec hanami generate action #{app} #{plural}#destroy --url="/#{plural}")
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end

Hanami::CLI.register "generate scaffold", Hanami::Scaffold::CLI::Command
