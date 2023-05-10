Attribute VB_Name = "Module1"
Sub Ticker_Updates()
    For Each ws In Worksheets

        Dim ticker As String
        
        Dim Open_Price As Double
        Dim Close_Price As Double
        
        Dim Yearly_change As Double
        Dim Percent_change As Double
        
        Dim Price_row As Long
        Price_row = 2
        
        total = 0
    
        Dim Summary_Table_Row As Integer
        Summary_Table_Row = 2
    
        ws.Range("I1").Value = "Ticker"
        ws.Range("J1").Value = "Yearly Change"
        ws.Range("K1").Value = "Percent Change"
        ws.Range("L1").Value = "Total Stock Volume"
    
        Lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        'setting loop
         For i = 2 To Lastrow:
             If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                'set ticker
                 ticker = ws.Cells(i, 1).Value
                'set Stock total volume
                 total = total + ws.Range("G" & i).Value
                 'Ticker name
                ws.Range("I" & Summary_Table_Row).Value = ticker
                'Stock Total Volume
                ws.Range("L" & Summary_Table_Row).Value = total
                
             
                 'Calculate YC and PC
                 Open_Price = ws.Range("C" & Price_row).Value
                Close_Price = ws.Range("F" & i).Value
                Yearly_change = Close_Price - Open_Price
             
                 If Open_Price = 0 Then
                    Percent_change = 0
                   Else
                        Percent_change = Yearly_change / Open_Price
                 End If
                'add value of YC and PC
                ws.Range("J" & Summary_Table_Row).Value = Yearly_change
                ws.Range("K" & Summary_Table_Row).Value = Percent_change
                ws.Range("K" & Summary_Table_Row).NumberFormat = "0.00%"
                
                    If ws.Range("J" & Summary_Table_Row).Value > 0 Then
                        ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4
                    Else
                        ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
                    End If
                    
               'add to the summary table row
                Summary_Table_Row = Summary_Table_Row + 1
                'reset the total stock volume
                total = 0
               Else
             total = total + ws.Range("G" & i).Value
            
             End If
          Next i
           'Set up greatest
           Greatest_Increase = ws.Range("K2").Value
           Greatest_Decrease = ws.Range("K2").Value
           Greatest_Total = ws.Range("L2").Value
           
           'Define the lastrow of ticker
           Lastrow_Ticker = ws.Cells(Rows.Count, "I").End(xlUp).Row
           
           'Now loop through to find the greatest
            For r = 2 To Lastrow_Ticker:
               If ws.Range("K" & r + 1).Value > Greatest_Increase Then
                  Greatest_Increase = ws.Range("K" & r + 1).Value
                  Greatest_Increase_Ticker = ws.Range("I" & r + 1).Value
               ElseIf ws.Range("K" & r + 1).Value < Greatest_Decrease Then
                  Greatest_Decrease = ws.Range("K" & r + 1).Value
                  Greatest_Decrease_Ticker = ws.Range("I" & r + 1).Value
                ElseIf ws.Range("L" & r + 1).Value > Greatest_Total Then
                  Greatest_Total = ws.Range("L" & r + 1).Value
                  Greatest_Total_Ticker = ws.Range("I" & r + 1).Value
                End If
            Next r
            
            'Now print the results in the spreadsheet
            ws.Range("P2").Value = Greatest_Increase_Ticker
            ws.Range("P3").Value = Greatest_Decrease_Ticker
            ws.Range("P4").Value = Greatest_Total_Ticker
            ws.Range("Q2").Value = Greatest_Increase
            ws.Range("Q3").Value = Greatest_Decrease
            ws.Range("Q4").Value = Greatest_Total
            ws.Range("Q2:Q3").NumberFormat = "0.00%"
           
           
          
    Next ws

    

End Sub
