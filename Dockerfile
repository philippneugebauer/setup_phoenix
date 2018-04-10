FROM elixir:1.6

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN mkdir /phoenix && chown -R daemon /phoenix

USER daemon

WORKDIR /phoenix
ENV HOME /phoenix
ENV MIX_ENV prod

RUN mix local.hex --force && mix local.rebar --force

COPY --chown=daemon mix.exs mix.lock ./
COPY --chown=daemon assets/package.json assets/package-lock.json assets/brunch-config.js assets/
RUN mix deps.get --only prod && cd assets && npm install

RUN mix compile

COPY --chown=daemon . /phoenix

RUN mix compile && cd assets && node_modules/brunch/bin/brunch build --production && cd .. && mix phx.digest

CMD mix ecto.migrate && mix phx.server