# Organization class for current subsystem
class Organization
    String name;
    String type;
    # holds all recent messages in orgnaization chat
    [String] messages;
    
    # renders a preview for the organization 
    # according to UI prototyupe
    # when clicked expands and shows the entire chat
    render_preview(color: String)

        def click_handler()
            self.render_chat(color)
        
        
        render(
            Box([
                Color(name, color),
                Box(MultiColor(messages[:3])),
            ]),
            click_handler
        )
    
    # renders the entire chat
    # when exited, returns to the preview state
    render_chat(color: String)

        def close_handler(){
            self.render_preview(color)
        }

        render([
            [Color(name, color), Color(x, "red", close_handler)],
            MultiColor(messages),  
        ])

# User class for current subsystem
class User
    string uid;
    
    # get get orgs column where uid column matches user uid
    get_orgs(db: Conn) -> [Organization]
        db.select_col_where("uid" == uid, "orgs")
    

# State holding important values useful to entire application
class AppState
    String uid;
    Conn db;
    ....


# run fn for subsytem
def run(app: AppState)

    # pull needed data out of app state
    user = User(app.user)
    conn = app.db
    
    # get all orgs users is registered with
    orgs = user.get_orgs(conn)
    
    # seperate organizations into clubs aned courfses
    clubs = filter(org.type == "club", orgs)
    courses = filter(org.type == "class", orgs)
    
    # render clubs and courses separatley according to UI prototyp
    render([
        Left([
            Box(Color("clubs", "purple")),
            map(render_preview("purple"), clubs)
        ]),
        Right([
            Box(Color("courses", "yellow")),
            map(render_preview("yellow"), courses),
        ]),
    ])

