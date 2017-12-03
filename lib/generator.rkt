#lang racket

(require css-expr)
(require scribble/html/xml)

(require (rename-in "styles.rkt" (styles main-styles)))
(require (rename-in "pages/index.rkt" (doc index-doc)))

(provide write-pages)

(define (write-file content file-path)
  (call-with-output-file file-path
    #:exists 'truncate
    (λ (out)
      (display content out))))

(define (write-page doc file-path)
  (write-file (xml->string doc ) file-path))

(define (write-stylesheet styles file-path)
  (write-file (css-expr->css styles) file-path))

(define (write-pages dir-path)
  (write-page index-doc (build-path dir-path "index.html"))
  (write-stylesheet main-styles (build-path dir-path "styles.css")))