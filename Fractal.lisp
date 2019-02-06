(defun c:jfract ( / a b c i im[c] lim re[c] res x xmax xmin y ymax ymin )
    (setvar 'PDMODE 0)
    (setq
        lim 255     ;; Iteration Limit

        xmin -0.60  ;; }
        xmax -0.30  ;; | Image
        ymin -0.35  ;; | Size
        ymax -0.05  ;; }

        res 0.0025  ;; Image Resolution

        Re[c] 0.285 ;; Real Coefficient of Julia Constant
        Im[c] 0.01  ;; Imaginary Coefficient of Julia Constant
    )
    (setq x (- xmin res))
    (while (<= (setq x (+ x res)) xmax)
        (setq y (- ymin res))
        (while (<= (setq y (+ y res)) ymax)
            (setq
                i 0
                a x
                b y
            )
            (while
                (and
                    (< (+ (* a a) (* b b)) 4.)
                    (<= (setq i (1+ i)) lim)
                )
                (setq
                    c (* 2.0 a b)
                    a (+ (- (* a a) (* b b)) Re[c])
                    b (+ c Im[c])
                )
            )
            (entmake
                (list
                   '(0 . "POINT")
                    (list 10 x y)
                    (cons 62 (1+ (rem (+ 30 i) 255)))
                )
            )
        )
    )
    (princ)
)
