(defpackage common-utils/parsers
  (:use :cl)
  (:nicknames :clu/p)
  (:import-from :parse-number :parse-real-number)
  (:export :parse-double))
(in-package :common-utils/parsers)


(defun parse-double (str)
  "Parse string with double float into double-float."
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (coerce (parse-real-number str :float-format 'double-float)
          'double-float))
