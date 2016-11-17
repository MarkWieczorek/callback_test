import callback_test
def f(status): raise Exception(status)
callback_test.pyfunc = f
callback_test.routine()
