#!/usr/bin/env bash

export SECRET_KEY_BASE=9mFSfacDTyugqSh+CMnn1LLSapCVsJQJ4MOIKB37f/ItIjfntEPsmkTM/6ewo0TP
export DATABASE_URL=ecto://postgres:postgres@localhost/less_impact_dev

mix deps.get --only prod
MIX_ENV=prod mix compile

npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

rm -rf "_build"
MIX_ENV=prod mix release
