
class StaticData
  ADDRESS = '0.0.0.0'
  PORT = 9292
  MAINPAGE = "http://#{ADDRESS}:#{PORT}"

  ALPHABET = ('a'..'z').to_a
end

class ErrorMessages
  UNCORRECT_LOGIN = "login or password is uncorrect"

  #region product
  UNCORRECT_PRODUCT_NAME = "is invalid"
  NOT_UNIQ_PRODUCT_NAME = "is already taken"
  PRODUCT_NOT_FOUND = "product is not found"
  PRODUCT_ID_WRONG = "product_id is not belongs to any product"
  #endregion product

  #region plan
  CANT_BE_EMPTY_PLAN_NAME = 'cannot be empty'
  PRODUCT_ID_CANT_BE_NIL_PLAN_NAME = "product_id can't be nil"
  PRODUCT_ID_CANT_BE_EMPTY_PLAN_NAME = "product_id can't be empty"
  PLAN_ID_CANT_BE_NIL_PLAN_NAME = "plan_id can't be nil"
  #endregion plan
end