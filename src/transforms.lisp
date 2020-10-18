(defpackage common-utils/transforms
  (:use :cl :series :alexandria)
  (:nicknames :clu/t)
  (:export #:transform-plist))
(in-package :common-utils/transforms)

(series::install)


(defun map-fn-key-init (pl key fn)
  (map-fn 'list (lambda (x) (list key x))
          (map-fn t fn (scan 'list (getf pl key)))))


(defun map-fn-scalar (&rest sers)
  (apply #'map-fn 'list (lambda (&rest y) (apply #'append y)) sers))


(defun map-fn-cartesian (&rest sers)
  (reduce
   (lambda (a b)
     (apply #'catenate
            (collect
                (map-fn t (lambda (y)
                            (map-fn t (lambda (x) (append y x)) a))
                        b))))
   sers))


(defun transform-plist (inpl &key (scalar nil) (cartesian nil))
  "Unrolls PLIST according to the encoding to simultaneous (scalar) and
many-to many (cartesian) inclusion schemes. Each member of SCALAR and
CARTESIAN lists is a cons cell with KEYword at car and at cdr a
function to map onto members of PLIST at KEY when unrolling.
Returns a SERIES. Rather raw implementation, possibly not optimal."
  (if (and (null scalar) (null cartesian))
      (scan (list inpl))
      (let ((base
              (apply #'remove-from-plist inpl
                     (loop :for cc :in (append scalar cartesian)
                           :collect (car cc))))
            (scalar-map
              (if scalar
                  (apply #'map-fn-scalar
                         (map 'list (lambda (c) (map-fn-key-init inpl (car c) (cdr c))) scalar))
                  nil))
            (cartesian-map
              (if cartesian
                  (apply #'map-fn-cartesian
                         (map 'list (lambda (c) (map-fn-key-init inpl (car c) (cdr c))) cartesian))
                  nil)))

        (map-fn 'list (lambda (l) (append base l))
                (if (and scalar-map cartesian-map)
                    (map-fn-cartesian scalar-map cartesian-map)
                    (or scalar-map cartesian-map))))))
