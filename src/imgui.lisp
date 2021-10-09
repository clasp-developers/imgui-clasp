(in-package :imgui)

#+(or)
(progn
  (defun get-absolute-path (path) (|getAbsolutePath| path))

  (defun make-seq-file-in (path)
    (if (probe-file path)
        (|make-SeqFileIn| path)
        (error "The file ~a does not exist" path)))

  (defun make-seq-file-out (path)
    (|make-SeqFileOut| path))

  (defgeneric write-record (file header data)
    (:method ((file |SeqFileOut|) (header |CharString|) (data |Dna5QString|))
      (|writeRecord(SeqFileOut&,CharString&,Dna5QString&)| file header data)))

  (defgeneric close (file)
    (:method ((file |SeqFileIn|)) (|close(SeqFileIn&)| file))
    (:method ((file |SeqFileOut|)) (|close(SeqFileOut&)| file)))

  (defgeneric make-string (kind &optional value)
    (:method ((kind (eql :char-string)) &optional (value ""))
      (|make-CharString| value))
    (:method ((kind (eql :dna-string)) &optional (value ""))
      (|make-DnaString| value))
    (:method ((kind (eql :dna5q-string)) &optional (value ""))
      (|make-Dna5QString| value)))

  (defgeneric make-string-set (kind)
    (:method ((kind (eql :char-string)))
      (|make-StringSet<CharString>|))
    (:method ((kind (eql :dna-string)))
      (|make-StringSet<DnaString>|))
    (:method ((kind (eql :dna5q-string)))
      (|make-StringSet<Dna5QString>|)))

  (defgeneric []& (sequence pos)
    (:method ((sequence |CharString|) pos) (|[](CharString&,int)->char&| sequence pos))
    (:method ((sequence |DnaString|) pos) (|[](DnaString&,int)->Dna&| sequence pos))
    (:method ((sequence |Dna5QString|) pos) (|[](Dna5QString&,int)->Dna5Q&| sequence pos)))

  (defgeneric ord-value (base)
    (:method ((base |Char|)) (|ordValue(Char&)| base))
    (:method ((base |Dna|)) (|ordValue(Dna&)| base))
    (:method ((base |Dna5Q|)) (|ordValue(Dna5Q&)| base)))

  (defgeneric get-quality-value (base)
    (:method ((base |Dna5Q|)) (|getQualityValue(Dna5Q&)| base)))

  (defgeneric length (finder)
    (:method ((finder |Finder<CharString,void>|)) (|length<Finder<CharString,void>>| finder))
    (:method ((finder |Finder<DnaString,void>|)) (|length<Finder<DnaString,void>>| finder))
    (:method ((finder |Finder<Dna5QString,void>|)) (|length<Finder<Dna5QString,void>>| finder))
    (:method ((finder |CharString|)) (|length(CharString)| finder))
    (:method ((finder |DnaString|)) (|length(DnaString)| finder))
    (:method ((finder |Dna5QString|)) (|length(Dna5QString)| finder))
    (:method ((finder |String<Gaps<CharString>>|)) (|length(String<Gaps<CharString>>)| finder ))
    (:method ((finder |String<Gaps<DnaString>>|)) (|length(String<Gaps<DnaString>>)| finder ))
    (:method ((finder |String<Gaps<Dna5QString>>|)) (|length(String<Gaps<Dna5QString>>)| finder ))
    (:method ((finder |Gaps<CharString>|)) (|length(Gaps<CharString>)| finder ))
    (:method ((finder |Gaps<DnaString>|)) (|length(Gaps<DnaString>)| finder ))
    (:method ((finder |Gaps<Dna5QString>|)) (|length(Gaps<Dna5QString>)| finder ))
    )

  (defgeneric count-quality-value-less-than (sequence quality &optional start end)
    (:method ((sequence |Dna5QString|) quality &optional (start 0) (end (length sequence)))
      (|countQualityValueLessThan(Dna5QString&,int,int,int)| sequence quality start end)))

  (defgeneric calculate-quality (sequence &optional start end)
    (:method ((sequence |Dna5QString|) &optional (start 0) (end (length sequence)))
      (|calculateQuality(Dna5QString&,int,int,string&)| sequence start end)))

  (defun make-simple-score (&optional (match 0) (mismatch -1) (gap -1) (gap-open gap))
    (|make-SimpleScore| match mismatch gap gap-open))
    
  (defgeneric append-value (needles sequence)
    (:method ((needles |StringSet<CharString>|) (sequence |CharString|))
      (|appendValue<StringSet<CharString>,CharString>| needles sequence))
    (:method ((needles |StringSet<DnaString>|) (sequence |DnaString|))
      (|appendValue<StringSet<DnaString>,DnaString>| needles sequence))
    (:method ((needles |StringSet<Dna5QString>|) (sequence |Dna5QString|))
      (|appendValue<StringSet<Dna5QString>,Dna5QString>| needles sequence)))


  (defgeneric at-end (file)
    (:method ((file |SeqFileOut|))
      (|atEnd(SeqFileOut&)| file))
    (:method ((file |SeqFileIn|))
      (|atEnd(SeqFileIn&)| file)))

  (defgeneric position (file)
    (:method ((file |SeqFileOut|))
      (|position(SeqFileOut&)| file))
    (:method ((file |SeqFileIn|))
      (|position(SeqFileIn&)| file)))

  (defgeneric read-record (metadata sequence file)
    (:method ((metadata |CharString|) (sequence |DnaString|) (file |SeqFileIn|))
      (|readRecord<CharString,DnaString,SeqFileIn>| metadata sequence file))
    (:method ((metadata |CharString|) (sequence |Dna5QString|) (file |SeqFileIn|))
      (|readRecord<CharString,Dna5QString,SeqFileIn>| metadata sequence file)))

  (defgeneric to-string (str)
    (:documentation "Convert SeqAn String<xxx> to a Common Lisp string")

    (:method ((str |Segment<CharString,PrefixSegment>|)) (|to-string(Segment<CharString,PrefixSegment>)| str))
    (:method ((str |Segment<CharString,InfixSegment>|)) (|to-string(Segment<CharString,InfixSegment>)| str))
    (:method ((str |Segment<CharString,SuffixSegment>|)) (|to-string(Segment<CharString,SuffixSegment>)| str))
    (:method ((str |Segment<DnaString,PrefixSegment>|)) (|to-string(Segment<DnaString,PrefixSegment>)| str))
    (:method ((str |Segment<DnaString,InfixSegment>|)) (|to-string(Segment<DnaString,InfixSegment>)| str))
    (:method ((str |Segment<DnaString,SuffixSegment>|)) (|to-string(Segment<DnaString,SuffixSegment>)| str))
    (:method ((str |Segment<Dna5QString,PrefixSegment>|)) (|to-string(Segment<Dna5QString,PrefixSegment>)| str))
    (:method ((str |Segment<Dna5QString,InfixSegment>|)) (|to-string(Segment<Dna5QString,InfixSegment>)| str))
    (:method ((str |Segment<Dna5QString,SuffixSegment>|)) (|to-string(Segment<Dna5QString,SuffixSegment>)| str))
  
    (:method ((str |CharString|)) (|to-string(CharString)| str))
    (:method ((str |DnaString|)) (|to-string(DnaString)| str))
    (:method ((str |Dna5QString|)) (|to-string(Dna5QString)| str))

    (:method ((str |Align<CharString,ArrayGaps>|)) (|to-string(Align<CharString,ArrayGaps>)| str))
    (:method ((str |Align<DnaString,ArrayGaps>|)) (|to-string(Align<DnaString,ArrayGaps>)| str))
    (:method ((str |Align<Dna5QString,ArrayGaps>|)) (|to-string(Align<Dna5QString,ArrayGaps>)| str))
    )


  (defgeneric make-finder (sequence)
    (:documentation "Create a finder of the appropriate type")
    (:method ((sequence |CharString|))
      (|make-Finder<CharString,void>| sequence))
    (:method ((sequence |DnaString|))
      (|make-Finder<DnaString,void>| sequence))
    (:method ((sequence |Dna5QString|))
      (|make-Finder<Dna5QString,void>| sequence)))



  (defgeneric make-pattern (needles score)
    (:documentation "Make a pattern templated on the needles and score")
    (:method ((needles |CharString|) (score |SimpleScore|))
      (|make-Pattern<CharString,DPSearch<SimpleScore>>| needles score))
    (:method ((needles |DnaString|) (score |SimpleScore|))
      (|make-Pattern<DnaString,DPSearch<SimpleScore>>| needles score))
    (:method ((needles |Dna5QString|) (score |SimpleScore|))
      (|make-Pattern<Dna5QString,DPSearch<SimpleScore>>| needles score))
    (:method ((needles |StringSet<CharString>|) (score |SimpleScore|))
      (|make-Pattern<StringSet<CharString>,DPSearch<SimpleScore>>| needles score))
    (:method ((needles |StringSet<DnaString>|) (score |SimpleScore|))
      (|make-Pattern<StringSet<DnaString>,DPSearch<SimpleScore>>| needles score))
    (:method ((needles |StringSet<Dna5QString>|) (score |SimpleScore|))
      (|make-Pattern<StringSet<Dna5QString>,DPSearch<SimpleScore>>| needles score)))

  (defgeneric find (finder pattern &optional minscore)
    (:documentation "Do a find")
    (:method ((finder |Finder<CharString,void>|)
              (pattern |Pattern<CharString,DPSearch<SimpleScore>>|)
              &optional (minscore 0))
      (|find<Finder<CharString,void>,Pattern<CharString,DPSearch<SimpleScore>>|
       finder
       pattern
       minscore))
    (:method ((finder |Finder<DnaString,void>|)
              (pattern |Pattern<DnaString,DPSearch<SimpleScore>>|)
              &optional (minscore 0))
      (|find<Finder<DnaString,void>,Pattern<DnaString,DPSearch<SimpleScore>>|
       finder
       pattern
       minscore))
    (:method ((finder |Finder<Dna5QString,void>|)
              (pattern |Pattern<Dna5QString,DPSearch<SimpleScore>>|)
              &optional (minscore 0))
      (|find<Finder<Dna5QString,void>,Pattern<Dna5QString>,DPSearch<SimpleScore>>|
       finder
       pattern
       minscore))

    #+(or)(:method ((finder |Finder<CharString,void>|)
                    (pattern |Pattern<StringSet<CharString>,DPSearch<SimpleScore>>|)
                    &optional (minscore 0))
            (|find<Finder<CharString,void>,Pattern<StringSet<CharString>,DPSearch<SimpleScore>>|
             finder
             pattern
             minscore))
    (:method ((finder |Finder<DnaString,void>|)
              (pattern |Pattern<StringSet<DnaString>,DPSearch<SimpleScore>>|)
              &optional (minscore 0))
      (|find<Finder<DnaString,void>,Pattern<StringSet<DnaString>,DPSearch<SimpleScore>>|
       finder
       pattern
       minscore))
    (:method ((finder |Finder<Dna5QString,void>|)
              (pattern |Pattern<StringSet<Dna5QString>,DPSearch<SimpleScore>>|)
              &optional (minscore 0))
      (|find<Finder<Dna5QString,void>,Pattern<StringSet<Dna5QString>,DPSearch<SimpleScore>>|
       finder
       pattern
       minscore))
    )

  (defgeneric get-score (pattern)
    (:method ((pattern |Pattern<CharString,DPSearch<SimpleScore>>|))
      (|getScore<Pattern<CharString,DPSearch<SimpleScore>>| pattern))
    (:method ((pattern |Pattern<DnaString,DPSearch<SimpleScore>>|))
      (|getScore<Pattern<DnaString,DPSearch<SimpleScore>>| pattern))
    (:method ((pattern |Pattern<Dna5QString,DPSearch<SimpleScore>>|))
      (|getScore<Pattern<Dna5QString,DPSearch<SimpleScore>>| pattern))
    (:method ((pattern |Pattern<StringSet<CharString>,DPSearch<SimpleScore>>|))
      (|getScore<Pattern<StringSet<CharString>,DPSearch<SimpleScore>>| pattern))
    (:method ((pattern |Pattern<StringSet<DnaString>,DPSearch<SimpleScore>>|))
      (|getScore<Pattern<StringSet<DnaString>,DPSearch<SimpleScore>>| pattern))
    (:method ((pattern |Pattern<StringSet<Dna5QString>,DPSearch<SimpleScore>>|))
      (|getScore<Pattern<StringSet<Dna5QString>,DPSearch<SimpleScore>>| pattern))
    )


  (defgeneric find-begin (finder pattern score)
    (:method ((finder |Finder<CharString,void>|)
              (pattern |Pattern<CharString,DPSearch<SimpleScore>>|)
              score)
      (|findBegin<Finder<CharString,void>,Pattern<CharString,DPSearch<SimpleScore>>|
       finder
       pattern
       score))
    (:method ((finder |Finder<DnaString,void>|)
              (pattern |Pattern<DnaString,DPSearch<SimpleScore>>|)
              score)
      (|findBegin<Finder<DnaString,void>,Pattern<DnaString,DPSearch<SimpleScore>>|
       finder
       pattern
       score))
    (:method ((finder |Finder<Dna5QString,void>|)
              (pattern |Pattern<Dna5QString,DPSearch<SimpleScore>>|)
              score)
      (|findBegin<Finder<Dna5QString,void>,Pattern<Dna5QString,DPSearch<SimpleScore>>|
       finder
       pattern
       score))
    #+(or)(:method ((finder |Finder<CharString,void>|)
                    (pattern |Pattern<StringSet<CharString>,DPSearch<SimpleScore>>|)
                    score)
            (|findBegin<Finder<CharString,void>,Pattern<StringSet<CharString>,DPSearch<SimpleScore>>|
             finder
             pattern
             score))
    (:method ((finder |Finder<DnaString,void>|)
              (pattern |Pattern<StringSet<DnaString>,DPSearch<SimpleScore>>|)
              score)
      (|findBegin<Finder<DnaString,void>,Pattern<StringSet<DnaString>,DPSearch<SimpleScore>>|
       finder
       pattern
       score))
    (:method ((finder |Finder<Dna5QString,void>|)
              (pattern |Pattern<StringSet<Dna5QString>,DPSearch<SimpleScore>>|)
              score)
      (|findBegin<Finder<Dna5QString,void>,Pattern<StringSet<Dna5QString>,DPSearch<SimpleScore>>|
       finder
       pattern
       score))
    )


  (defgeneric begin-position (obj)
    (:method ((obj |Finder<CharString,void>|)) (|beginPosition<Finder<CharString,void>>| obj))
    (:method ((obj |Finder<DnaString,void>|)) (|beginPosition<Finder<DnaString,void>>| obj))
    (:method ((obj |Finder<Dna5QString,void>|)) (|beginPosition<Finder<Dna5QString,void>>| obj))
    (:method ((obj |Gaps<CharString>|)) (|beginPosition(Gaps<CharString>&)| obj))
    (:method ((obj |Gaps<DnaString>|)) (|beginPosition(Gaps<DnaString>&)| obj))
    (:method ((obj |Gaps<Dna5QString>|)) (|beginPosition(Gaps<Dna5QString>&)| obj))
    )

  (defgeneric end-position (obj)
    (:method ((obj |Finder<CharString,void>|)) (|endPosition<Finder<CharString,void>>| obj))
    (:method ((obj |Finder<DnaString,void>|)) (|endPosition<Finder<DnaString,void>>| obj))
    (:method ((obj |Finder<Dna5QString,void>|)) (|endPosition<Finder<Dna5QString,void>>| obj))
    (:method ((obj |Gaps<CharString>|)) (|endPosition(Gaps<CharString>&)| obj))
    (:method ((obj |Gaps<DnaString>|)) (|endPosition(Gaps<DnaString>&)| obj))
    (:method ((obj |Gaps<Dna5QString>|)) (|endPosition(Gaps<Dna5QString>&)| obj))
    )

  (defgeneric infix-finder (finder)
    (:method ((finder |Finder<CharString,void>|)) (|infix<Finder<CharString,void>>| finder))
    (:method ((finder |Finder<DnaString,void>|)) (|infix<Finder<DnaString,void>>| finder))
    (:method ((finder |Finder<Dna5QString,void>|)) (|infix<Finder<Dna5QString,void>>| finder))
    )

  (defgeneric to-source-position (obj index)
    (:method ((obj |Gaps<CharString>|) index)
      (if (< index (length obj))
          (|toSourcePosition(Gaps<CharString>,int)| obj index)
          (error "Illegal index ~a must be less than ~a" index (length obj))))
    (:method ((obj |Gaps<DnaString>|) index)
      (if (< index (length obj))
          (|toSourcePosition(Gaps<DnaString>,int)| obj index)
          (error "Illegal index ~a must be less than ~a" index (length obj))))
    (:method ((obj |Gaps<Dna5QString>|) index)
      (if (< index (length obj))
          (|toSourcePosition(Gaps<Dna5QString>,int)| obj index)
          (error "Illegal index ~a must be less than ~a" index (length obj))))
    )

  (defgeneric to-view-position (obj index)
    (:method ((obj |Gaps<CharString>|) index) (|toViewPosition(Gaps<CharString>,int)| obj index))
    (:method ((obj |Gaps<DnaString>|) index) (|toViewPosition(Gaps<DnaString>,int)| obj index))
    (:method ((obj |Gaps<Dna5QString>|) index) (|toViewPosition(Gaps<Dna5QString>,int)| obj index))
    )
  (defgeneric make-align (kind)
    (:method ((kind (eql :char-string))) (|make-Align<CharString,ArrayGaps>|))
    (:method ((kind (eql :dna-string))) (|make-Align<DnaString,ArrayGaps>|))
    (:method ((kind (eql :dna5q-string))) (|make-Align<Dna5QString,ArrayGaps>|))
    )

  (defgeneric row& (align index)
    (:documentation "Return a REFERENCE to a row - don't let the result escape")
    (:method ((align |Align<CharString,ArrayGaps>|) index) (|row&(Align<CharString,ArrayGaps>,int)| align index))
    (:method ((align |Align<DnaString,ArrayGaps>|) index) (|row&(Align<DnaString,ArrayGaps>,int)| align index))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) index) (|row&(Align<Dna5QString,ArrayGaps>,int)| align index))
    )

  (defgeneric rows& (align)
    (:documentation "Return a REFERENCE to a collection of rows - don't let the result escape")
    (:method ((align |Align<CharString,ArrayGaps>|)) (|rows&(Align<CharString,ArrayGaps>)| align))
    (:method ((align |Align<DnaString,ArrayGaps>|)) (|rows&(Align<DnaString,ArrayGaps>)| align))
    (:method ((align |Align<Dna5QString,ArrayGaps>|)) (|rows&(Align<Dna5QString,ArrayGaps>)| align))
    )

  (defgeneric resize (rows num)
    (:method ((rows |String<Gaps<CharString>>|) num)
      (|resize<String<Gaps<CharString>>>| rows num))
    (:method ((rows |String<Gaps<DnaString>>|) num)
      (|resize<String<Gaps<DnaString>>>| rows num))
    (:method ((rows |String<Gaps<Dna5QString>>|) num)
      (|resize<String<Gaps<Dna5QString>>>| rows num))
    )

  (defgeneric assign-source (row num)
    (:method ((row |Gaps<CharString>|) num)
      (|assignSource(Gaps<CharString>&,int)| row num))
    (:method ((row |Gaps<DnaString>|) num)
      (|assignSource(Gaps<DnaString>&,int)| row num))
    (:method ((row |Gaps<Dna5QString>|) num)
      (|assignSource(Gaps<Dna5QString>&,int)| row num))
    )


  (defgeneric set-begin-position (row source-pos)
    (:method ((row |Gaps<CharString>|) source-pos)
      (|setBeginPosition(Gaps<CharString>&,int)| row source-pos))
    (:method ((row |Gaps<DnaString>|) source-pos)
      (|setBeginPosition(Gaps<DnaString>&,int)| row source-pos))
    (:method ((row |Gaps<Dna5QString>|) source-pos)
      (|setBeginPosition(Gaps<Dna5QString>&,int)| row source-pos))
    )
  (defgeneric insert-gap (row view-pos)
    (:method ((row |Gaps<CharString>|) view-pos)
      (|insertGap(Gaps<CharString>&,int)| row view-pos))
    (:method ((row |Gaps<DnaString>|) view-pos)
      (|insertGap(Gaps<DnaString>&,int)| row view-pos))
    (:method ((row |Gaps<Dna5QString>|) view-pos)
      (|insertGap(Gaps<Dna5QString>&,int)| row view-pos))
    )

  (defgeneric insert-gaps (row view-pos count)
    (:method ((row |Gaps<CharString>|) view-pos count) (|insertGaps(Gaps<CharString>&,int,int)| row view-pos count))
    (:method ((row |Gaps<DnaString>|) view-pos count) (|insertGaps(Gaps<DnaString>&,int,int)| row view-pos count))
    (:method ((row |Gaps<Dna5QString>|) view-pos count) (|insertGaps(Gaps<Dna5QString>&,int,int)| row view-pos count))
    )

  (defun make-align-config (&optional (kind :nil-nil-nil-nil))
    (ecase kind
      (:nil-nil-nil-nil (|make-AlignConfig<false,false,false,false>|))
      (:nil-t-t-nil     (|make-AlignConfig<false,true,true,false>|))
      (:t-nil-nil-t     (|make-AlignConfig<true,false,false,true>|))
      ))


  (defgeneric global-alignment-all (align score align-config)
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,false,false,false>|))
      (|globalAlignment(Align<CharString,ArrayGaps>,SimpleScore,AlignConfig<false,false,false,false>)| align score align-config))
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,true,true,false>|))
      (|globalAlignment(Align<CharString,ArrayGaps>,SimpleScore,AlignConfig<false,true,true,false>)| align score align-config))
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<true,false,false,true>|))
      (|globalAlignment(Align<CharString,ArrayGaps>,SimpleScore,AlignConfig<true,false,false,true>)| align score align-config))
    (:method ((align |Align<DnaString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,false,false,false>|))
      (|globalAlignment(Align<DnaString,ArrayGaps>,SimpleScore,AlignConfig<false,false,false,false>)| align score align-config))
    (:method ((align |Align<DnaString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,true,true,false>|))
      (|globalAlignment(Align<DnaString,ArrayGaps>,SimpleScore,AlignConfig<false,true,true,false>)| align score align-config))
    (:method ((align |Align<DnaString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<true,false,false,true>|))
      (|globalAlignment(Align<DnaString,ArrayGaps>,SimpleScore,AlignConfig<true,false,false,true>)| align score align-config))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,false,false,false>|))
      (|globalAlignment(Align<Dna5QString,ArrayGaps>,SimpleScore,AlignConfig<false,false,false,false>)| align score align-config))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,true,true,false>|))
      (|globalAlignment(Align<Dna5QString,ArrayGaps>,SimpleScore,AlignConfig<false,true,true,false>)| align score align-config))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<true,false,false,true>|))
      (|globalAlignment(Align<Dna5QString,ArrayGaps>,SimpleScore,AlignConfig<true,false,false,true>)| align score align-config))
    )

  (defgeneric global-alignment-banded (align score align-config lower-diagonal upper-diagonal)
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,false,false,false>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<CharString,ArrayGaps>,SimpleScore,AlignConfig<false,false,false,false>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,true,true,false>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<CharString,ArrayGaps>,SimpleScore,AlignConfig<false,true,true,false>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<true,false,false,true>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<CharString,ArrayGaps>,SimpleScore,AlignConfig<true,false,false,true>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<DnaString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,false,false,false>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<DnaString,ArrayGaps>,SimpleScore,AlignConfig<false,false,false,false>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<DnaString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,true,true,false>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<DnaString,ArrayGaps>,SimpleScore,AlignConfig<false,true,true,false>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<true,false,false,true>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<Dna5QString,ArrayGaps>,SimpleScore,AlignConfig<true,false,false,true>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,false,false,false>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<Dna5QString,ArrayGaps>,SimpleScore,AlignConfig<false,false,false,false>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<false,true,true,false>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<Dna5QString,ArrayGaps>,SimpleScore,AlignConfig<false,true,true,false>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) (align-config |AlignConfig<true,false,false,true>|) lower-diagonal upper-diagonal)
      (|globalAlignment(Align<Dna5QString,ArrayGaps>,SimpleScore,AlignConfig<true,false,false,true>,int,int)|
       align score align-config lower-diagonal upper-diagonal))
    )

  (defmacro global-alignment (align score
                              &optional
                                (align-config '(sa:make-align-config :nil-nil-nil-nil))
                                (lower-diagonal nil lower-diagonal-p)
                                (upper-diagonal nil upper-diagonal-p))
    (if (null (and lower-diagonal-p upper-diagonal-p))
        `(global-alignment-all ,align ,score ,align-config)
        `(global-alignment-banded ,align ,score ,align-config ,lower-diagonal ,upper-diagonal)))

  (defgeneric local-alignment-all (align score)
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|))
      (|localAlignment(Align<CharString,ArrayGaps>&,SimpleScore&)| align score))
    (:method ((align |Align<DnaString,ArrayGaps>|) (score |SimpleScore|))
      (|localAlignment(Align<DnaString,ArrayGaps>&,SimpleScore&)| align score))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|))
      (|localAlignment(Align<Dna5QString,ArrayGaps>&,SimpleScore&)| align score))
    )

  (defgeneric local-alignment-banded (align score lower-diagonal upper-diagonal)
    (:method ((align |Align<CharString,ArrayGaps>|) (score |SimpleScore|) lower-diagonal upper-diagonal)
      (|localAlignment(Align<CharString,ArrayGaps>&,SimpleScore&)| align score lower-diagonal upper-diagonal))
    (:method ((align |Align<DnaString,ArrayGaps>|) (score |SimpleScore|) lower-diagonal upper-diagonal)
      (|localAlignment(Align<DnaString,ArrayGaps>&,SimpleScore&)| align score lower-diagonal upper-diagonal))
    (:method ((align |Align<Dna5QString,ArrayGaps>|) (score |SimpleScore|) lower-diagonal upper-diagonal)
      (|localAlignment(Align<Dna5QString,ArrayGaps>&,SimpleScore&)| align score lower-diagonal upper-diagonal))
    )

  (defgeneric assign (target source)
    (:method ((target core:str8ns) (source |Dna5QString|))
      (|assign(Str8Ns_sp,Dna5QString&)| target source)))


  (defmacro local-alignment (align score &rest args)
    (if (= 0 (length args))
        `(local-alignment-all ,align ,score)
        `(apply 'local-alignment-banded ,align ,score ,args)))

  )
