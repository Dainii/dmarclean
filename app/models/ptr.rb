# frozen_string_literal: true

require 'ipaddr'

class Ptr
  def self.resolve(address)
    cached_value = Rails.cache.read("dns_#{address}")

    return cached_value if cached_value

    value = 'n/a'

    begin
      ip_address = IPAddr.new(address)

      resolver = Dnsruby::Resolver.new
      query = resolver.query(ip_address.to_s, 'PTR', 'IN')

      value = query.answer.first.domainname.to_s
      ttl = query.answer.first.ttl

      Rails.cache.write("dns_#{address}", value, expires_in: ttl.seconds)
    rescue IPAddr::InvalidAddressError
      value = 'Not a valid IPv4 or IPv6 address'
    rescue StandardError
      value = 'Unknown address'
    end

    value
  end
end
