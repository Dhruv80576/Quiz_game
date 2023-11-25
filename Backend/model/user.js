class User{
    constructor(name,email,password,role){
        this.name=name;
        this.email=email;
        this.password=password;
        this.role=role;
    }
    getpassword(){
        return this.password;
    }
    getemail(){
        return this.email;
    }
    getname(){
        return this.name;
    }
    getrole(){
        return this.role;
    }
}