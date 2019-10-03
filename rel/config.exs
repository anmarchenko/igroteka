# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Distillery.Releases.Config,
  # This sets the default release built by `mix release`
  default_release: :default,
  # This sets the default environment used by `mix release`
  default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html

# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :prod do
  set(include_erts: true)
  set(include_src: false)
  set(cookie: :"<}nAUtuE;Ocsq$re0>]fGgMw%JveGacduS&_2*8sW}gxEzlZ{IeTotIthaiF)F/g")
  set(vm_args: "rel/vm.args")
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :skaro do
  set(version: current_version(:skaro))

  set(
    applications: [
      :runtime_tools
    ]
  )

  set(
    commands: [
      migrate: "rel/commands/migrate.sh",
      create_db: "rel/commands/create_db.sh"
    ]
  )
end
