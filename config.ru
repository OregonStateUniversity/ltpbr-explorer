# This file is used by Rack-based servers to start the application.

run lambda { |env|
  [
    301,
    { 'location' => 'https://pbr.riverscapes.net', 'content-type' => 'text/html' },
    ['Redirecting to <a href="https://pbr.riverscapes.net">https://https://pbr.riverscapes.net</a>']
  ]
}
