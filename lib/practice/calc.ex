defmodule Practice.Calc do
    def calc(expr) do
        expr
        |> String.split(~r/\s+/)
        |> infixToPostfix([])
        |> evalPostfix([])
 
    end
 
    def infixToPostfix(exprList, stack) do
        if length(exprList) === 0 do
            if length(stack) === 0 do
                []
            else
                [hd(stack)] ++ infixToPostfix(exprList, tl(stack))
            end
        else 
            if isNumber(hd(exprList)) do
                [hd(exprList)] ++ infixToPostfix(tl(exprList), stack)
            else
                {addedOutput, updatedStack} = pemdasFunc(hd(exprList), stack, [])
                addedOutput ++ infixToPostfix(tl(exprList), updatedStack)
            end
        end
 
 
    end
 
    def isNumber(str) do
        not (Integer.parse(str) == :error)
    end
 
    # returns true if the first input operation takes priority
    # over the second input operation
    def opPriority(op1, op2) do
        if op1 == "*" || op1 == "/" do
            op2 != "*" && op2 != "/"
        else
            false
        end
    end
 
    def pemdasFunc(op, stack, acc) do
        if length(stack) === 0 do
            {acc, [op]}
        else
            if opPriority(op, hd(stack)) do
                {acc, [op] ++ stack}
            else
                pemdasFunc(op, tl(stack), acc ++ [hd(stack)])
            end
        end
    end
 
    def evalPostfix(postfixExpr, stack) do
        if length(postfixExpr) === 0 do
            if length(stack) === 1 do
                {answer, _} = Integer.parse(hd(stack))
		answer
            else
                IO.puts "INVALID INPUT"
            end
        else
            if isNumber(hd(postfixExpr)) do
                evalPostfix(tl(postfixExpr), [hd(postfixExpr)] ++ stack)
            else
                evalPostfix(tl(postfixExpr), [eval(hd(postfixExpr), hd(tl(stack)), hd(stack))] ++ tl(tl(stack)))
            end
        end
    end
 
    def eval(op, num1, num2) do
        {num1Parsed, _} = Integer.parse(num1)
        {num2Parsed, _} = Integer.parse(num2)
        output = 
        case op do
            "+" ->
                num1Parsed + num2Parsed
            "-" ->
                num1Parsed - num2Parsed
            "*" ->
                num1Parsed * num2Parsed
            "/" ->
                num1Parsed / num2Parsed
            _ ->
                IO.puts "Invalid Operation"
        end
 
        to_string(output)
    end
 
end
