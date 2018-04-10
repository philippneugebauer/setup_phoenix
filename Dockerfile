# not latest to ensure the elixir version and prevent surprising incompatibility crashes
FROM elixir:1.6

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN mkdir /phoenix && chown -R daemon /phoenix

# no root to prevent break outs through shared docker socket
USER daemon

WORKDIR /phoenix
ENV HOME /phoenix
ENV MIX_ENV prod

RUN mix local.hex --force && mix local.rebar --force

# --chown sets user at copying and avoids second slow chown call
# copying dependency files utilizes caching and lowers average build time since general files change often but do not influence dependency checks
COPY --chown=daemon mix.exs mix.lock ./
COPY --chown=daemon assets/package.json assets/package-lock.json assets/brunch-config.js assets/
RUN mix deps.get --only prod && cd assets && npm install

# cache compilation of libraries to speed up build time
RUN mix compile

# copy application => following steps will happen all the time
COPY --chown=daemon . /phoenix

# compile current application
RUN mix compile && cd assets && node_modules/brunch/bin/brunch build --production && cd .. && mix phx.digest

# for more than 1 instance, optimistic approach
CMD mix ecto.migrate && mix phx.server