settings = YAML.load File.read(File.expand_path("../../settings.yml", __FILE__))
settings.merge! settings.fetch(Rails.env, {}).with_indifferent_access
settings.symbolize_keys!
SETTINGS = settings.with_indifferent_access
