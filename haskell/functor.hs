e :: IO Integer
e = 
  let 
    ioi = (readIO "1") :: IO Integer
    changed = (fmap read) $ fmap (("123" ++) . show) ioi :: IO Integer
  in
    fmap (*3) changed


