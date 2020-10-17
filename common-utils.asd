(defsystem "common-utils"
  :version "0.1.0"
  :author "Vladimir Dikan"
  :license "MIT"
  :depends-on ("parse-number"
               "alexandria"
               "series")
  :components ((:module "src"
                :components
                ((:file "parsers")
                 (:file "transforms"))))
  :description "Handy CL definitions for everyday use."
  :in-order-to ((test-op (test-op "common-utils/tests"))))


(defsystem "common-utils/tests"
  :author "Vladimir Dikan"
  :license "MIT"
  :depends-on ("common-utils"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "parsers")
                 (:file "transforms"))))
  :description "Test system for common-utils"
  :perform (test-op (op c) (symbol-call :rove :run c)))

;; NOTE: To run this tests, execute `(asdf:test-system :common-utils)' in your Lisp.
