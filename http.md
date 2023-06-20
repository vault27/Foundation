# HTTP

## Headers

### Content-type

Using this header we can identify which file is downloaded:

- text/plain is the default value for textual files. A textual file should be human-readable and must not contain binary data
- application/octet-stream is the default value for all other cases. An unknown file type should use this type - EXE and MSI for example have this type
- text/html
- image/jpeg
- application/json

All types are available on the internet, it is called MIME types.  
MIME - Multipurpose Internet Mail Extensions - Internet Standard - created for SMTP - used in HTTP as well - describes different file types - clients use it to better understand how to process data
