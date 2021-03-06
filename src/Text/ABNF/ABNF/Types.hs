{-|
Module      : Text.ABNF.ABNF.Types
Description : Types used by the parser
Copyright   : (c) Martin Zeller, 2016
License     : BSD2
Maintainer  : Martin Zeller <mz.bremerhaven@gmail.com>
Stability   : experimental
Portability : portable

These types are used by the parser and are loosely modeled after the ABNF
privded in <https://tools.ietf.org/html/rfc5234#section-4 RFC 5234>
-}
module Text.ABNF.ABNF.Types where

import qualified Data.Text as Text

-- | A 'Rule' represents a single entry in your ABNF. It could, for example,
-- look like this:
--
-- @
-- CRLF = %x0D.0A
-- @
data Rule = Rule Text.Text DefinedAs SumSpec
    deriving (Show, Eq)

data SumSpec = SumSpec [ProductSpec]
    deriving (Show, Eq)

data ProductSpec = ProductSpec [Repetition]
    deriving (Show, Eq)

data Repetition = Repetition Repeat Element
    deriving (Show, Eq)

data Repeat = Repeat Int (Maybe Int)
    deriving (Show, Eq)

data Element = RuleElement' Text.Text
             | RuleElement Rule
             | GroupElement Group
             | OptionElement Group
             | LiteralElement Literal
             deriving (Show, Eq)

data Group = Group SumSpec
    deriving (Show, Eq)

data Literal = CharLit Text.Text | NumLit NumLit
    deriving (Show, Eq)

data NumLit = IntLit [Int]
            | RangeLit Int Int
            deriving (Show, Eq)

data DefinedAs = Equals | Adds
    deriving (Show, Eq)
