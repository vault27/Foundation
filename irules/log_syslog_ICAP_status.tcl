when RULE_INIT {
    set static::SyslogIP "10.1.1.228"
    set static::debug 1
}
when ICAP_REQUEST {
    set http_host [HTTP::host]
    set client_addr [IP::client_addr]
}
when ICAP_RESPONSE {
    log $static::SyslogIP local0. "ICAP status code from DLP is [ICAP::status] for $client_addr is requesting $http_host"
    if {$static::debug ne 0} {
        log local0. "ICAP status code from DLP is [ICAP::status] for $client_addr is requesting $http_host"
    }
}