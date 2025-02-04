when HTTP_REQUEST priority 100 {

if { [HTTP::host] eq "domain.com" } { HTTP::redirect "https://www.domain.com[HTTP::uri]"

# Disable further processing for HTTP_REQUEST
        event disable
        return
}
}
