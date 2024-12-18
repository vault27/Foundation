when HTTP_REQUEST {
if { [HTTP::host] eq "domain.com" } { HTTP::redirect "https://domain.com[HTTP::uri]"
}
}
