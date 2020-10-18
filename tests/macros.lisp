(defpackage common-utils/tests/macros
  (:use :cl
        :common-utils/macros
        :rove))
(in-package :common-utils/tests/macros)


(deftest test-parse-double
  (testing "should read .bashrc"
    (ok (string-equal
         (aproc "cat ~/.bashrc"
           (if (= 0 (uiop:wait-process proc))
               "success" "fail"))
         "success"))))
