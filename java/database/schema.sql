BEGIN TRANSACTION;

DROP TABLE IF EXISTS landmark_itinerary, itinerary, landmark_open, user_landmark, landmark, users CASCADE;
DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


CREATE TABLE users
(
    user_id       int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
    username      varchar(50)                                  NOT NULL,
    password_hash varchar(200)                                 NOT NULL,
    role          varchar(50)                                  NOT NULL,
    CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE landmark
(
    landmark_id serial,
    name        varchar(50)  NOT NULL,
    description text         NOT NULL,
    tagline     text,
    days_hours  varchar(100) NOT NULL,
    category    varchar(50)  NOT NULL,
    image_url      varchar(200),
    thumbs_up   int DEFAULT 0,
    thumbs_down int DEFAULT 0,
    place_id	varchar(100),
    latitude    decimal,
    longitude   decimal,
    address     varchar      NOT NULL,
  
    CONSTRAINT PK_landmark_id PRIMARY KEY (landmark_id)
);

CREATE TABLE landmark_open
(
    days_id     serial,
    landmark_id int     NOT NULL,
    monday      boolean NOT NULL,
    tuesday     boolean NOT NULL,
    wednesday   boolean NOT NULL,
    thursday    boolean NOT NULL,
    friday      boolean NOT NULL,
    saturday    boolean NOT NULL,
    sunday      boolean NOT NULL,
    CONSTRAINT PK_days_id PRIMARY KEY (days_id),
    CONSTRAINT FK_landmark FOREIGN KEY (landmark_id) REFERENCES landmark (landmark_id)
);

CREATE TABLE itinerary
(
    itinerary_id   serial,
    itinerary_name varchar(50) NOT NULL,
    user_id        int         NOT NULL,
    starting_name varchar,
    starting_address varchar,
    starting_latitude decimal,
    starting_longitude decimal,
    itinerary_date date NOT NULL,
    shared      boolean      NOT NULL,
    CONSTRAINT PK_itinerary_id PRIMARY KEY (itinerary_id),
    CONSTRAINT FK_itinerary_user FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE landmark_itinerary
(
    landmark_id  int,
    itinerary_id int,
    CONSTRAINT PK_landmark_itinerary PRIMARY KEY (landmark_id, itinerary_id),
    CONSTRAINT FK_landmark_itinerary_landmark FOREIGN KEY (landmark_id) REFERENCES landmark (landmark_id),
    CONSTRAINT FK_landmark_itinerary_itinerary FOREIGN KEY (itinerary_id) REFERENCES itinerary (itinerary_id)
);

CREATE TABLE user_landmark
(
    user_id int,
    landmark_id int,
    gave_thumbs_up boolean DEFAULT false,
    gave_thumbs_down boolean DEFAULT false,
    CONSTRAINT PK_user_landmark PRIMARY KEY (user_id, landmark_id),
    CONSTRAINT FK_user_landmark_user FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT FK_user_landmark_landmark FOREIGN KEY (landmark_id) REFERENCES landmark (landmark_id)
);

INSERT INTO users (username, password_hash, role)
VALUES ('user', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER');
INSERT INTO users (username, password_hash, role)
VALUES ('admin', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_ADMIN');

INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Museum Of Science and Industry',
        'The Museum of Science and Industry is a science museum located in Chicago, Illinois, in Jackson Park, in the Hyde Park neighborhood between Lake Michigan and The University of Chicago. It is housed in the former Palace of Fine Arts from the 1893 World''s Columbian Exposition. Initially endowed by Julius Rosenwald, the Sears, Roebuck and Company president and philanthropist, it was supported by the Commercial Club of Chicago and opened in 1933 during the Century of Progress Exposition. Among the museum''s exhibits are a full-size replica coal mine, German submarine U-505 captured during World War II, a 3,500-square-foot model railroad, the command module of Apollo 8, and the first diesel-powered streamlined stainless-steel passenger train.',
        'Interactive educational museum',
        'Daily 9:30am - 4:00pm',
        'Museum',
        'https://lh3.googleusercontent.com/places/AAcXr8rsiPXt_N2uRim6jXtqfsocu2WALCOgG-0CCiFRG2C2hawKHJeeKjcdTWgofzHN1sdYub_0XBOAi6DaBbdTBTSeKrMD6Bcg4Dk=s1600-w400',
        23,
        4,
	'ChIJHd8BYAopDogRBuMXc6oszA8',
        41.7906,
        -87.5831,
        '5700 S DuSable Lake Shore Dr, Chicago, IL 60637');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Shedd Aquarium',
        'Shedd Aquarium is an indoor public aquarium in Chicago, Illinois, in the United States. Opened on May 30, 1930, the 5 million US gal aquarium was for some time the largest indoor facility in the world. Today it holds about 32,000 animals. Shedd Aquarium was the first inland aquarium with a permanent saltwater fish collection. It is located on Lake Michigan, on the Museum Campus Chicago, along with the Adler Planetarium and the Field Museum of Natural History. In 2015, the aquarium had 2.02 million visitors. It was the most visited aquarium in the U.S. in 2005, and in 2007, it surpassed the Field Museum as the most popular cultural attraction in Chicago. The aquarium contains 1,500 species, including fish, marine mammals, birds, snakes, amphibians, and insects. The aquarium received awards for "best exhibit" from the Association of Zoos and Aquariums for Seahorse Symphony in 1999, Amazon Rising in 2001, and Wild Reef in 2004. It was designated a National Historic Landmark in 1987.',
        'Aquatic creatures from around the world',
        'Daily 9am - 5pm',
        'Entertainment',
        'https://lh3.googleusercontent.com/places/AAcXr8paHLTl_MAvpOQZjKAXIo1rCI18tM0nOPQhqANRJDvQI9w4PwTrSloAEGobL20Fqc2mgyjExub5nVOwZDb20eDfBkCPy5eLiX4=s1600-w400',
        31,
        5,
	'ChIJ-XW3X2MrDogR3_tQ3-OdBTI',
        41.8676,
        -87.6140,
        '1200 S DuSable Lake Shore Dr, Chicago, IL 60605');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Millennium Park',
        'Millennium Park is a public park located in the Loop community area of Chicago, operated by the Chicago Department of Cultural Affairs. The park, intended to celebrate the third millennium, is a prominent civic center near the city''s Lake Michigan shoreline that covers a 24.5-acre section of northwestern Grant Park.',
        'Green space with art, theater, and ice rink',
        'Daily 6am - 11pm',
        'Landmark',
        'https://lh3.googleusercontent.com/places/AAcXr8ppeXVAo-OMaKdzQ4rgL9NSDjFfqS-jOB0KGaLzD2lFkpX0CDKgnNHL0KMHYMMvs-YdJQKNX9j-SH1XGUHII8eplUp3yT9iWUU=s1600-w400',
        16,
        8,
	'ChIJA5xPiqYsDogRBBCptdwsGEQ',
        41.8827,
        -87.6233,
        '201 E Randolph St, Chicago, IL 60602');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Adler Planetarium',
        'For Chicagoans who can pick out the Big Dipper and not much else in the night sky, the Adler Planetarium can open up a whole new universe. In addition to shows and exhibits at its theaters, galleries, and observatory, the Adler provides astronomy education for students, adults, and families through a variety of course offerings, lectures, and other special events. Its museum, one of the largest of its kind in the world, features some 2,000 historic astronomy, navigation, and mathematics instruments. Opened in 1930, the Adler was the first planetarium built in the Western Hemisphere.',
        'Museum with high-tech exhibits & shows',
        'Thurs - Tue 9am - 4pm, Wed 4pm - 10pm',
        'Landmark',
        'https://lh3.googleusercontent.com/places/AAcXr8oI_ix64MM-QIjom3Jdeq9GTHIpLoPEpUMaP-FW3tjEX_lX4uBpJ_w_4CFCo-PW6ebi5FW8_uoBIpkfPVy4UfblGPu5a6lcgXw=s1600-w400',
        27,
        7,
	'ChIJtRSxt28rDogRpo4hEqqjIGk',
        41.8661,
        -87.6196,
        '1300 S DuSable Lake Shore Dr, Chicago, IL 60605');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Field Museum',
        'The Field Museum of Natural History, also known as The Field Museum, is a natural history museum in Chicago, Illinois, and is one of the largest such museums in the world. The museum is a popular natural-history museum for the size and quality of its educational and scientific programs, as well as due to its extensive scientific-specimen and artifact collections. The permanent exhibitions, which attract up to two million visitors annually, include fossils, current cultures from around the world, and interactive programming demonstrating today''s urgent conservation needs. The museum is named in honor of its first major benefactor, the department-store magnate Marshall Field. The museum and its collections originated from the 1893 World''s Columbian Exposition and the artifacts displayed at the fair. ',
        'State-of-the-art science museum',
        'Daily 9am - 5pm',
        'Museum',
        'https://lh3.googleusercontent.com/places/AAcXr8phkhCNRR5MQ7I_ZREH612Mn0IJ-Qb76eGBfuadEafKBwsQHCAOV5q5jaK2wVo-G6Yu3aI4Xoq1bcAbXr6TzJLQiIZD7GNq-lU=s1600-w400',
        41,
        8,
	'ChIJV0AwM30rDogR2sd-X0cgErU',
        41.8663,
        -87.6170,
        '1400 S Lake Shore Dr, Chicago, IL 60605');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Art Institute of Chicago',
        'Equal parts museum and academic institution, The Art Institute of Chicago has been a fixture on the creative landscape since its founding by a group of artists in 1879. With a famous pair of bronze lions standing sentry, the not-for-profit organization''s museum houses some 300,000 works of art in a dozen collections ranging from Asian art to architecture to textiles. The Art Institute of Chicago is also home to the Ryerson and Burnham Libraries, which together constitute one of the world''s largest art museum libraries.',
        'Renowned art museum with global works',
        'Thurs - Mon 11am - 5pm',
        'Museum',
        'https://lh3.googleusercontent.com/places/AAcXr8ppFPPtw24k6isfdJf6Xr6BOrUtGwTSJ5dYijPIbkFlmMZdfP03E9klMGRe35Kyk7AhX-DjKpbsKPmmu_ZCOf9SqatjAuviOhc=s1600-w400',
        31,
        5,
	'ChIJlUbZ4qMsDogR3tCinMzzKUg',
        41.8796,
        -87.6237,
        '111 South Michigan Avenue, Chicago, IL 60603');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Navy Pier',
        'Navy Pier is a 3,300-foot-long pier on the shoreline of Lake Michigan, located in the Streeterville neighborhood of the Near North Side community area in Chicago, Illinois, United States. Navy Pier encompasses over 50 acres of parks, gardens, shops, restaurants, family attractions and exhibition facilities and is one of the top destinations in the Midwestern United States, drawing nearly over nine million visitors annually. It is one of the most visited attractions in the entire Midwest and is Chicago''s second-most visited tourist attraction.',
        'Destination with rides, shops & food',
        'Sun - Thurs 11am - 8pm, Fri - Sat 11am - 10pm',
        'Landmark',
        'https://lh3.googleusercontent.com/places/AAcXr8oFcq1H8CJ_taKOZdLLfXC3hLQRLUDeYgSlh1hrK8hrFCsPexiCzn92vtLn2q2z43CO69f6E0kKrD14UN3TieC1H8c6B-PiMks=s1600-w400',
        32,
        10,
	'ChIJ2y7xkU0rDogR3KSIsJbbrNA',
        41.8919,
        -87.6051,
        '600 E Grand Ave, Chicago, IL 60611');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Wrigley Field',
        'Wrigley Field is a Major League Baseball stadium located on the North Side of Chicago, Illinois. It is the home of the Chicago Cubs, one of the city''s two MLB franchises. It first opened in 1914 as Weeghman Park for Charles Weeghman''s Chicago Whales of the Federal League, which folded after the 1915 baseball season. The Cubs played their first home game at the park on April 20, 1916, defeating the Cincinnati Reds 7–6 in 11 innings. Chewing gum magnate William Wrigley Jr. of the Wrigley Company acquired the Cubs in 1921. It was named Cubs Park from 1920 to 1926, before being renamed Wrigley Field in 1927. The stadium offers tours, which provide an insider''s look at more than 100 years of history in this legendary ballpark.',
        'Cubs’ historic ballpark',
        'Tours Daily 9AM - 4PM',
        'Sports',
        'https://lh3.googleusercontent.com/places/AAcXr8ozQNcCC87vhbKJYMzlRD--V2zuVr8xJ-ismK_utGLM9gt8an4GjTtsur2vkPuzBfro3TFDXv3UxBsYSnkmY_iKT-LHdbxUnl0=s1600-w400',
        63,
        2,
	'ChIJId-a5bLTD4gRRtbdduE-6hw',
        41.9484,
        -87.6553,
        '1060 W Addison St, Chicago, IL 60613');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Lincoln Park Zoo',
        'Lincoln Park Zoo aka Lincoln Park Zoological Gardens is a 35-acre zoo in Lincoln Park, Chicago, Illinois. The zoo was founded in 1868, making it the fourth oldest zoo in North America. It is also one of a few free admission zoos in the United States. The zoo is an accredited member of the Association of Zoos and Aquariums. Lincoln Park Zoo is home to a wide variety of animals. The zoo''s exhibits include big cats, polar bears, penguins, gorillas, reptiles, monkeys, and other species totaling about 1,100 animals from some 200 species. Also located in Lincoln Park Zoo is a burr oak tree which dates to 1830, three years before the city of Chicago was organized.',
        'Free zoo with an interactive farm',
        'Daily 10am - 5pm',
        'Entertainment',
        'https://lh3.googleusercontent.com/places/AAcXr8qTCsJxExUTC0dP__rSzcvLRn-EBGn5oLuRfK4rGU_DUBId1ArOXiTeGFXVMgM2JkmUOJQCrATl7nQYhe0r8CizetLIGK8jWfA=s1600-w400',
        23,
        4,
	'ChIJB5o6CWvTD4gR25QC-QbMQAk',
        41.9217,
        -87.6336,
        '2001 N Clark St, Chicago, IL 60614');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Brookfield Zoo',
        'Brookfield Zoo, also known as the Chicago Zoopark, is a zoo located in the Chicago suburb of Brookfield, Illinois. It houses around 450 species of animals in an area of 216 acres. It opened on July 1, 1934, and quickly gained international recognition for using moats and ditches instead of cages to separate animals from visitors and from other animals. The zoo was also the first in America to exhibit giant pandas, one of which has been taxidermied and put on display in Chicago''s Field Museum of Natural History. In 1960, Brookfield Zoo built the nation''s first fully indoor dolphin exhibit, and in the 1980s, the zoo introduced Tropic World, the first fully indoor rainforest simulation and the then-largest indoor zoo exhibit in the world.',
        'Sprawling zoo with thousands of animals',
        'Daily 9:30am - 6pm',
        'Entertainment',
        'https://lh3.googleusercontent.com/places/AAcXr8rG2SEQrY-6tVttxjePlzJNmmtyUr6hNuWhqAHzVMo6Nnqs8rV05okHymgXs4ZWEpK9HjoPL1jQiuZoivxYiwLkaXPO9kP81DE=s1600-w400',
        31,
        6,
	'ChIJL-_gtOk1DogRlc9I1l-jYBs',
        41.8329,
        -87.8356,
        '8400 W 31st St, Brookfield, IL 60513');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Cloud Gate',
        'Cloud Gate is a public sculpture by Indian-born British artist Anish Kapoor, that is the centerpiece of AT&T Plaza at Millennium Park in the Loop community area of Chicago, Illinois. The sculpture and AT&T Plaza are located on top of Park Grill, between the Chase Promenade and McCormick Tribune Plaza & Ice Rink. Constructed between 2004 and 2006, the sculpture is nicknamed "the Bean" because of its shape, a name Kapoor initially disliked, but later grew fond of. Made up of 168 stainless steel plates welded together, its highly polished exterior has no visible seams. It measures 33 by 66 by 42 feet, and weighs 110 short tons. Kapoor''s design was inspired by liquid mercury and the sculpture''s surface reflects and distorts the city''s skyline.',
        'Mirrored, bean-shaped sculpture',
        'Daily 6am - 11pm',
        'Landmark',
        'https://lh3.googleusercontent.com/places/AAcXr8rDqg3O-sk-Nfw--NMHDNvURgEb1vNcpBWsfNwSoZvasGpvKc3w5ZgmQiiV6froQaTNxy6mJrcWpzn_z6iXAYCEqMVXVJqU2W8=s1600-w400',
        19,
        5,
	'ChIJ9Sszh6YsDogRUUo6zu8_TQY',
        41.8827,
        -87.6233,
        '201 E Randolph St, Chicago, IL 60602');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Willis Tower',
        'The Willis Tower (formerly the Sears Tower) is a 108-story, 1,450-foot (442.1 m) skyscraper. It is currently the third-tallest building in the United States and the Western hemisphere – and the 23rd-tallest in the world. Each year, more than one million people visit its observation deck, the highest in the United States, making it one of Chicago''s most popular tourist destinations. At completion in 1974, it surpassed the World Trade Center in New York City to become the tallest building in the world, a title that it held for nearly 25 years. It was also the tallest building in the Western Hemisphere for 41 years, until the One World Trade Center surpassed it in 2013, and had the highest occupiable floor until surpassed by the Central Park Tower in 2022. The Willis Tower is considered a seminal achievement for engineer Fazlur Rahman Khan.',
        'Super-tall skyscraper with city vistas',
        'Daily 9am - 10pm',
        'Landmark',
        'https://lh3.googleusercontent.com/places/AAcXr8ryhKLjpzwXkATqkARQhozmCTc543Um_-oBo-lyOiHzbEHjFNy-LM4htBs0cYERK00PvkgTrpggDHuGe8dahrrWGw4BPGaWxjs=s1600-w400',
        44,
        10,
	'ChIJu_tp4r4sDogRfYy4Xs5tDwE',
        41.8789,
        -87.6359,
        '233 S Wacker Dr, Chicago, IL 60606');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Soldier Field',
        'Soldier Field is a multi-purpose stadium on the Near South Side.Opened in 1924, the stadium has served as the home of the Chicago Bears of the National Football League (NFL) since 1971, as well as the Chicago Fire of Major League Soccer (MLS) since 2020. Soldier Field has a football capacity of 61,500, and is the oldest stadium in the NFL and MLS. Soldier Field has served as the home venue for a number of other sports teams in its history, including the Chicago Cardinals of the NFL and University of Notre Dame football, as well as the 1994 FIFA World Cup, the 1999 FIFA Women''s World Cup, and multiple CONCACAF Gold Cup championships.',
        'Historic football stadium',
        'Daily 6am - 11pm',
        'Sports',
        'https://lh3.googleusercontent.com/places/AAcXr8omsADe6U4_bh2Hr3k6KuRHlxCmJHQjkQIErUDUT-UGZBSwDPwH7zSY21A72xMQFrSM2geFC05BdoXaTrwJvZRKlagTTO0sIuA=s1600-w400',
        34,
        7,
	'ChIJu-eVtX0rDogRnAL4r-ucyaM',
        41.8623,
        -87.6167,
        '1410 Special Olympics Dr, Chicago, IL 60605');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Guaranteed Rate Field',
        'Guaranteed Rate Field is a baseball stadium located on the South Side. It serves as the home stadium of the Chicago White Sox. The stadium was built directly across 35th Street from the original Comiskey Park, the former ballpark the White Sox had played at since 1910. Completed at a cost of US$137 million, the park opened as Comiskey Park on April 18, 1991, taking its name from the former ballpark the White Sox had played at since 1910. In 2003, it was renamed U.S. Cellular Field after Chicago-based telecommunications company U.S. Cellular purchased the naming rights at US$68 million for 20 years. The stadium''s current name was announced on October 31, 2016, after the Chicago-based private residential mortgage company Guaranteed Rate purchased the naming rights in a 13-year deal.',
        'White Sox Home Stadium',
        'Season From April - October',
        'Sports',
        'https://lh3.googleusercontent.com/places/AAcXr8r8DwY5P_irqVN1W8Qxbgi0Hj0pqjzqTaKWHcVVnBtgUL5bPBkVHIFUqVlkBy_4CLc-xg-31pBM0lghztmTP2rnxEHY4zY3WrE=s1600-w400',
        9,
        19,
	'ChIJ9ZKOJxQsDogRuJBKj2ZPhi8',
        41.8299,
        -87.6338,
        '333 W 35th St, Chicago, IL 60616');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Lou Malnati''s Pizzeria',
        'Lou Malnati''s Pizzeria is an American Chicago-style pizza restaurant chain.  It was founded by the son of Rudy Malnati, who was instrumental in developing the recipe for Chicago-style pizza, and it has become one of the Chicago area''s best-known local lines of pizza restaurants. Lou Malnati''s operates a division of its company called Lou Malnati''s Presents Tastes of Chicago, a partnership with Portillo''s Restaurants and Eli''s Cheesecake, which ships Chicago-style cuisine nationally.',
        'Chicago-style Pizza Chain',
        'Mon - Thurs 4pm - 10pm, Fri - Sat 11am - 11pm, Sun 11am - 10pm',
        'Food & Beverage',
        'https://lh3.googleusercontent.com/places/AAcXr8obds19fZ9tLv9fvr2ONVmS1hHTO0A_FeCW3Uu64F4GHW2pFrBphuow_sy0M_vQT2xrzmS6nCmekE68XTrjdGm5TPHcZwbP_qs=s1600-w400',
        23,
        15,
	'ChIJU_XAKk7TD4gRmLD590uUQEY',
        41.90275823,
        -87.62857584,
        '1120 N State St, Chicago, IL 60610');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Pequod''s Pizza',
        'Known as the Home of Chicago''s Iconic “Caramelized Crust” Pan-Style Deep-Dish Pizza, Pequod''s is a casual, brick-walled pub where deep-dish pies are served until late. Pequods opened in 1970 in the northwest suburbs of Chicago and became the best known secret for pizza in town. In 1992, they finally opened a location in the Lincoln Park neightborhood of Chicago.Thanks to the enthusiastic patronage of loyal customers, Pequod’s began to build a new cult following in the Windy City, quickly becoming known for late night pizza and delivery of their world class deep dish pizza.',
        '“Caramelized Crust” Deep-Dish Pizza',
        'Mon - Sat 11am - 2am, Sun 11am - 12am',
        'Food & Beverage',
        'https://lh3.googleusercontent.com/places/AAcXr8qVfrDMhKSZq1oc-U6vzcgLkLbYhdLrhokTEgqyCkURPrgvS5X-mitGbLKGOGGqbXDTG1CkHra77K7j2tYW76AMvW-MumPeUxA=s1600-w400',
        42,
        18,
	'ChIJQ6vcPuTSD4gRTbyKKQufF_o',
        41.9219,
        -87.6644,
        '2207 N Clybourn Ave, Chicago, IL 60614');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Giordano''s',
        'Giordano''s is an American pizzeria chain that specializes in Chicago-style stuffed pizza. Brothers Efren and Joseph Boglio founded Giordano''s in 1974 in Chicago, Illinois. The pizzeria has since expanded to over 65 locations across the United States. Giordano''s stuffed pizza has received wide acclaim from critics, being named "Best Pizza in the City" by Chicago Magazine and "Best Pizza in America" by NBC''s The Today Show.',
        'Chicago-style Stuffed Pizza',
        'Daily 11am - 12am',
        'Food & Beverage',
        'https://lh3.googleusercontent.com/places/AAcXr8rAA90Tx_WgEkI5Eaqedu6EYKGXWHPcs2cFQqZod9PYW4N-4j6LagLGrL2c7SY3MA_3-Avjnudm1jV0OlYQVMYE4DmqYu087R4=s1600-w400',
        41,
        19,
	'ChIJuTHCJVPTD4gR_-KiOJ4h5Uc',
        41.8958,
        -87.6257,
        '730 N Rush St, Chicago, IL 60611');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Goose Island Brewhouse',
        'Goose Island Brewhouse is the longest continuously operating craft brewery in Chicago. Founded in 1988, this historic brewpub offers one-of-a-kind beers and pub fare from a scratch kitchen. The brewery was built in 1995 and has more than doubled in size since originally built. They offer tasty pints using 32 fermenters, over 15 different yeasts, state-of-the-art filters, centrifuges and a 50 barrel JV Northwest 5 vessel system that brews 24 hours a day, 7 days a week.',
        'Brewery Founded In Chicago',
        'Tues - Thurs 12am - 10pm, Fri 12pm - 11pm, Sat 11am - 11pm, Sun 11am - 8pm',
        'Food & Beverage',
        'https://lh3.googleusercontent.com/places/AAcXr8p56OW5I_f1fAl3vmJPodE6GLZZeDjRRaG1aVtH5_fmNdW3RvBZ81xbYiJCx0w_t1FECuUo_avJwq20xA97eZ3U6r02KgHiReE=s1600-w400',
        30,
        2,
	'ChIJGUsemCHTD4gRdrBxeW4gyDs',
        41.9132,
        -87.6544,
        '1800 N Clybourn Ave, Chicago, IL 60614');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('The Second City',
        'The Second City is an improvisational comedy enterprise and is the first ongoing improvisational theater troupe to be continually based in Chicago. The Second City Theatre opened as a small comedy cabaret in 1959, and has since become one of the most influential and prolific comedy theatres in the world, with theaters and training centers in Chicago, Toronto, and Hollywood.',
        'Comedy Theater',
        'Main Stage Show: Tues - Thurs 8pm, Fri - Sat 7pm & 10pm, Sun 7pm',
        'Entertainment',
        'https://lh3.googleusercontent.com/places/AAcXr8rYlw6wnzVB39YEuLBIa3acNvXNFZMe0_AfIqOGsKrOziF7yZrN6RYUxbjedODk0w-1jqtJJ21wDg27LqmQ4AxJvqsMZlHJ2fQ=s1600-w400',
        28,
        13,
	'ChIJFR3zFUHTD4gRiSGHi3J4B7Y',
        41.9113,
        -87.6349,
        '230 W North Ave, Chicago, IL 60614');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('House of Blues',
        'House of Blues is an American chain of live music concert halls and restaurants. It was founded by Isaac Tigrett, the co-founder of Hard Rock Cafe, and Dan Aykroyd, co-star of the 1980 film The Blues Brothers. The House of Blues mission is to celebrate and demonstrate the power of music to bring people together. Its founders drew inspiration from world culture, art and spiritual tenets in order to create a welcoming environment that would bring forth the mantra, Unity in Diversity.',
        'Live Music Venue',
        'Wed - Mon 5pm - 11pm',
        'Entertainment',
        'https://lh3.googleusercontent.com/places/AAcXr8q4QkWG3VgQ3Cv7y1VsGhbo2lgwl7kNstx-_h6sXIM2Wk9Mpu7OFcxn9Zqdj89OhQ8rNCj0C4kOoFosguoEZOSq9kMXiQpvNrU=s1600-w400',
        29,
        5,
	'ChIJ05UHzLEsDogRSZiv23eq-Mg',
        41.8882,
        -87.6291,
        '329 N Dearborn St, Chicago, IL 60654');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('North Avenue Beach',
        'The North Avenue Beach, located at 1600 North, is considered by many to be Chicago''s premier beach. It has the largest lifeguard staff and is home to the most developed beachhouse. The beach hosts international volleyball tournaments as well as millions of sun worshippers every year. Chicago Park District lines the beach with poles for individuals and leagues to hang volleyball nets.',
        'Beach On Lake Michigan',
        'Daily 6am - 11pm',
        'Landmark',
        'https://lh3.googleusercontent.com/places/AAcXr8oIkQbJKdKmK25Na2VGWs0_nXx1PBegKV3NcmgsEHVaqfcXa_GbRvyjtQH4K7kvfmhPzIlI5tBgqiEt2AYHqSjCAWmKPwZk6bU=s1600-w400',
        52,
        11,
	'ChIJDw9m7GbTD4gRfxvHEJFgLBs',
        41.9172,
        -87.6270,
        '1601 N. Jean-Baptiste Pointe DuSable Lake Shore Drive, Chicago, IL 60611');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Garrets Popcorn',
        'The first shop opened in downtown Chicago in 1949. The majority of its brick and mortar stores are still in Chicago, including shops on the Magnificent Mile and in the O''Hare International Airport. As such, it is often referenced as part of classic Chicago cuisine. Garrett Popcorn was started by a female entrepreneur, who developed the now-famous recipes in her family kitchen. The first Shops in Chicago sold CaramelCrisp, CheeseCorn, Buttery and Plain for 5 cents a bag alongside homemade fudge and roasted nuts.',
        'Chicago-style Gourmet Popcorn',
        'Daily 10am - 8pm',
        'Food & Beverage',
        'https://lh3.googleusercontent.com/places/AAcXr8oFx886R-cFAqPh4-P8aBEvbGUfCBBCzjmn2BickqG5Pui82QXMTBmYWmvVMmx1Ty59yU45nbGuERtQ_zqGn0p1hfYDUnTMdTU=s1600-w400',
        41,
        23,
	'ChIJLfnG-aUsDogRYI0qsgSvNc8',
        41.88523143,
        -87.62420323,
        '173 Michigan Ave, Chicago, IL 60601');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Fulton Market',
        'The former warehouse district of Fulton Market is now a hip corporate and entertainment area known for creative global and modern American restaurants around West Fulton Market Street. There are also cafes serving house-roasted coffee and buzzing breweries and cocktail bars, some with live music.',
        'Restaurant District',
        'Daily 10am - 11pm',
        'Food & Beverage',
        'https://lh3.googleusercontent.com/places/AAcXr8qotPEMduDOBgEUmZNC2erB6SDojMraVaVGB2TBMd95Ci8wCnKxJx1kf2lotJum3s_MX8T5aqR1qa003bxHAoAM3sZhjrJJzRA=s1600-w400',
        31,
        9,
	'ChIJneTjidAsDogRs67BSLxwTGM',
        41.8856,
        -87.6509,
        '800 W Fulton Market, Chicago, IL 60607');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Architecture Boat Tours',
        'Chicago is known around the world for its architectural feats, both inside and outside of the buildings. From the 100-year-old Art Deco, Neo-Classical, and Gothic Towers, to some of the tallest modern-day skyscrapers, Chicago is where old meets futuristic architectural endeavors. It has something for everyone in a way that no other city replicates today.',
        'Architectural Boat Tours on the Chicago River',
        'Daily 10am - 8pm',
        'Entertainment',
        'https://lh3.googleusercontent.com/places/AAcXr8rjHqaqjEtb6juEFuneIIL4ZspmvofM4TtoHPAiGrygxZgTlPZwRGzET5_thlica4vTAENIDcOnaDuc4xonxivP3zU-H38yEGs=s1600-w400',
        42,
        11,
	'ChIJO-S6va4sDogRPJQe4l7DSgk',
        41.8894,
        -87.6247,
        '400 N Michigan Ave, Chicago, IL 60611');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('Magnificent Mile',
        'The Magnificent Mile, sometimes referred to as The Mag Mile, is an upscale section of Chicago''s Michigan Avenue, running from the Chicago River to Oak Street in the Near North Side. The vibrant, bustling area is home to upscale shops, luxe fashion outlets, cool restaurants and posh hotels. Landmarks include the historic Chicago Water Tower, the neo-Gothic Tribune Tower, the terracotta Wrigley Building skyscraper and the 100-story John Hancock Center, which has a rooftop observation deck with fine dining and panoramic city views.',
        'Premier Commercial District',
        'Daily 9am - 10pm',
        'Landmark',
        'https://lh3.googleusercontent.com/places/AAcXr8qSIEe-Gn-JSkYdJ5KmF98CJrX1JUmf2afFMl-r-Yn0RqWYRHADdPDJkQPPWP1AR6E5KesM_yEBzA1nLmySfxBuPF-VnwqxRKU=s1600-w400',
        44,
        22,
	'ChIJr-ihyFbTD4gR81mealSWir4',
        41.8948,
        -87.6242,
        'Magnificent Mile, Chicago, IL 60611');
INSERT INTO landmark (name, description, tagline, days_hours, category, image_url, thumbs_up, thumbs_down, place_id, latitude, longitude, address)
VALUES ('United Center',
        'It is home to the Chicago Bulls of the National Basketball Association (NBA) and the Chicago Blackhawks of the National Hockey League (NHL). It is named after its corporate sponsor United Airlines, which has been based in Chicago since 2007. With a capacity of nearly 21,000, the United Center is the largest arena by capacity in the NBA, and second largest arena by capacity in the NHL.',
        'Home of the Chicago Bulls & Blackhawks',
        'Bulls Season from October - April, Blackhawks Season from October - June',
        'Sports',
        'https://lh3.googleusercontent.com/places/AAcXr8rDJEEK09VLXInwE0cS3kElOuBzaiuEKk-rGKKIh9tlhVD6TkRSkfJzOjTvubEqOf_4Bj417UdLlNYGma66k5QgtoLYZ1FR13g=s1600-w400',
        45,
        23,
	'ChIJT7Wpyj4tDogRRAPwjAbwk5s',
        41.8807,
        -87.6742,
        '1901 W Madison St, Chicago, IL 60612');

INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Museum Of Science and Industry'), true, true, true, true, true,
        true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Shedd Aquarium'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Millennium Park'), true, true, true, true, true, true,
        true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Adler Planetarium'), true, true, true, true, true, true,
        true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Field Museum'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Art Institute of Chicago'), true, false, false, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Navy Pier'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Wrigley Field'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Lincoln Park Zoo'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Brookfield Zoo'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Cloud Gate'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Willis Tower'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Soldier Field'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Guaranteed Rate Field'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Lou Malnati''s Pizzeria'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Pequod''s Pizza'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Giordano''s'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Goose Island Brewhouse'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'The Second City'), false, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'House of Blues'), true, false, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'North Avenue Beach'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Garrets Popcorn'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Fulton Market'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Architecture Boat Tours'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'Magnificent Mile'), true, true, true, true, true, true, true);
INSERT INTO landmark_open(landmark_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
VALUES ((SELECT landmark_id FROM landmark WHERE name = 'United Center'), true, true, true, true, true, true, true);

INSERT INTO itinerary(itinerary_name, user_id, starting_name, starting_address, starting_latitude, starting_longitude, itinerary_date, shared)
VALUES ('Tech Elevator Reunion', 1, 'Lincoln Park', 'Lincoln Park, Chicago, IL, USA', 41.9254701, -87.6487783, '2022-07-10', true);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (7,1);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (15,1);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (11,1);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (19,1);
INSERT INTO itinerary(itinerary_name, user_id, starting_name, starting_address, starting_latitude, starting_longitude, itinerary_date, shared)
VALUES ('Museum Tour', 1, '555 W Roosevelt RD', '555 W Roosevelt Rd, Chicago, IL 60607, USA', 41.8671766, -87.6414657, '2022-06-18', true);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (5,2);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (6,2);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (1,2);
INSERT INTO  landmark_itinerary(landmark_id, itinerary_id)
VALUES (4,2);
INSERT INTO itinerary(itinerary_name, user_id, starting_name, starting_address, starting_latitude, starting_longitude, itinerary_date, shared)
VALUES ('Saturday June 15th', 2, 'Lincoln Park', 'Lincoln Park, Chicago, IL, USA', 41.9254701, -87.6487783, '2022-06-15', false);

COMMIT TRANSACTION;