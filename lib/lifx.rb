require "lifx/version"
require "bindata"
require "bindata_ext/bool"
require "bindata_ext/record"
require "lifx/utilities"
require "lifx/logging"

%w(device light sensor wan wifi message).each { |f| require "lifx/protocol/#{f}" }
require "lifx/protocol/type"
require "lifx/message"
require "lifx/transport"

require "lifx/config"
require "lifx/client"

module LIFX
  UINT64_MAX = 2 ** 64 - 1
end
