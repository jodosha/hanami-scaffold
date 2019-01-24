# frozen_string_literal: true

require "shellwords"
require "hanami/utils/string"
require "hanami/cli/commands"

module Hanami
  module Scaffold
    module CLI
      class Command < Hanami::CLI::Commands::Command
        desc "Generate scaffold"

        argument :app,   "The app name"
        argument :model, "The model name"

        # rubocop:disable Metrics/MethodLength
        def call(app, model, **)
          app      = Shellwords.escape(app)
          singular = Shellwords.escape(model)
          plural   = Utils::String.pluralize(singular)

          exec "bundle exec hanami generate model #{singular}"

          exec "bundle exec hanami generate action #{app} #{plural}#index --url=/#{plural}"
          exec "bundle exec hanami generate action #{app} #{plural}#show --url=/#{plural}"
          exec "bundle exec hanami generate action #{app} #{plural}#new --url=/#{plural}/new"
          exec "bundle exec hanami generate action #{app} #{plural}#create --url=/#{plural}"
          exec "bundle exec hanami generate action #{app} #{plural}#edit --url=/#{plural}/edit"
          exec "bundle exec hanami generate action #{app} #{plural}#update --url=/#{plural}"
          exec "bundle exec hanami generate action #{app} #{plural}#destroy --url=/#{plural}"
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end

Hanami::CLI.register "generate scaffold", Hanami::Scaffold::CLI::Command
