(defpackage common-utils/macros
  (:use :cl)
  (:nicknames :clu/m)
  (:export #:aproc :proc))
(in-package :common-utils/macros)


(defmacro aproc (command &body body)
  "Anaphoric process launcher. Refer to process instance as PROC in &BODY."
  `(let ((proc (uiop:launch-program
                ,command :output :stream :error-output :stream)))
     (values ,@body (uiop:close-streams proc))))
