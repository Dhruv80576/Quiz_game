class Question{
    constructor(question,options,answer,level){
        this.question=question;
        this.options=options;
        this.answer=answer;
        this.level=level;
        
    }
    getquestion(){
        return this.question;
    }
    getoptions(){
        return this.options;
    }
    getanswer(){
        return this.answer;
    }
    getlevel(){
        return this.level;
    }
}