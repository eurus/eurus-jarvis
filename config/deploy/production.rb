role :app, %w{deploy@eurus.cn}
server 'eurus.cn',
  user: 'deploy',
  roles: %w{app},
  ssh_options: {
    forward_agent: true,
    auth_methods: %w(password),
    password: 'eurusdeploy'
}
