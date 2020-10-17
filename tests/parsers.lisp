(defpackage common-utils/tests/parsers
  (:use :cl
        :common-utils/parsers
        :rove))
(in-package :common-utils/tests/parsers)


(deftest test-parse-double
  (testing "should parse double-float from string"
    (ok (eq (type-of (parse-double "2.71828")) 'double-float))
    (ok (= (parse-double "-3.141592653589793")
           -3.141592653589793d0)))
  (testing "doubles are forced"
    (ok (= 443d0 (parse-double "443")))
    (ok (eq (type-of (parse-double "887")) 'double-float))))
