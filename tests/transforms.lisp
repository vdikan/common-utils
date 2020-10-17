(defpackage common-utils/tests/transforms
  (:use
   :cl
   :series
   :common-utils/transforms
   :rove))
(in-package :common-utils/tests/transforms)


(deftest test-transform-plist
  (testing "Should transform plist."
    (ok (equal (collect
                   (transform-plist '(:a "foo" :b ("bar" "baz") :c (1 2 3) :d (5 15) :e (10 20))
                                    :scalar `((:b . ,(lambda (x) (identity x)))
                                              (:c . ,(lambda (x) (* 2 x))))
                                    :cartesian `((:d . ,(lambda (x) (* x x)))
                                                 (:e . ,(lambda (x) (identity x))))))
               `((:A "foo" :E 10 :D 25 :B "bar" :C 2)
                 (:A "foo" :E 10 :D 25 :B "baz" :C 4)
                 (:A "foo" :E 10 :D 225 :B "bar" :C 2)
                 (:A "foo" :E 10 :D 225 :B "baz" :C 4)
                 (:A "foo" :E 20 :D 25 :B "bar" :C 2)
                 (:A "foo" :E 20 :D 25 :B "baz" :C 4)
                 (:A "foo" :E 20 :D 225 :B "bar" :C 2)
                 (:A "foo" :E 20 :D 225 :B "baz" :C 4)))))
  (testing "Should leave it alone."
    (ok (equal (collect (transform-plist '(:a "foo" :b ("bar" "baz"))))
               '((:a "foo" :b ("bar" "baz")))))))
