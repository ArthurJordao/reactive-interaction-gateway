FROM elixir:1.5

# Install Elixir & Erlang environment dependencies
RUN mix local.hex --force
RUN mix local.rebar --force

ENV MIX_ENV=prod

WORKDIR /opt/sites/rig

# Copy necessary files for dependencies
COPY mix.exs /opt/sites/rig
COPY mix.lock /opt/sites/rig

# Install project dependencies
RUN mix deps.get

# Copy application files
COPY config /opt/sites/rig/config
COPY lib /opt/sites/rig/lib
COPY priv /opt/sites/rig/priv

# Initialize release & compile application
RUN mix release.init
# Release application production code
CMD ["mix", "release"]
