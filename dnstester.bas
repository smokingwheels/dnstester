Randomize Timer
DefInt A-Z

Open "/home/nextcloud/Downloads/qb64/dns/dnstesterlog.csv" For Output As #2
On Error GoTo resetindex
'https://tricorder.pi-hole.net/IfVvFYnS/


digloop:
For k = 1 To 15
    If InKey$ = Chr$(27) Then End
    a = (25 * Rnd) + 97
    b = (25 * Rnd) + 97
    c = (25 * Rnd) + 97
    d = (25 * Rnd) + 97

    domain$ = Chr$(a%) + Chr$(b%) + Chr$(c%) + Chr$(d%) + ".com"
    index& = index& + 1
    Shell "dig @192.168.1.55 " + domain$ + " > /home/nextcloud/Downloads/qb64/dns/1.txt"
    '192.168.1.55 no error
    '192.168.1.5 error
    '220.233.0.4 exetel primary error
    '58.96.3.34 exetel error
    '1.1.1.1 no error
    '1.0.0.1 no error
    '8.8.4.4 error 115
    '9.9.9.10 quad 9 unfiltered errors
    ' 61.9.242.33 telstra

    Open "/home/nextcloud/Downloads/qb64/dns/1.txt" For Input As #1

    For i = 1 To 15
        Input #1, a$
    Next

    Do While Not EOF(1)
        Input #1, a$
        lline = Len(a$)
        '   ;; Query time:
        If Left$(a$, 5) = ";; Qu" Then
            b$ = Right$(a$, lline - 14)
            bline = Len(b$)
            'Print b$

            Print index&, domain$, Left$(b$, bline - 4)
            Print #2, Left$(b$, bline - 4)


            GoTo digexit
        End If
    Loop

    digexit:
    Close #1
Next
Sleep 1
GoTo digloop

resetindex:

Print "Error at " + Str$(index&)
index& = 0
Close #1
GoTo digloop


