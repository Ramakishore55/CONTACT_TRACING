import { LightningElement, track } from 'lwc';

export default class BookMyShowApp extends LightningElement {
    @track searchTerm = '';
    @track selectedCity = 'Mumbai';
    @track selectedLanguage = '';
    @track selectedGenre = '';
    @track selectedMovie = null;
    @track selectedTheater = null;
    @track selectedShowTime = null;
    @track selectedDate = '';
    @track selectedSeats = [];
    @track totalAmount = 0;
    @track bookingId = '';

    // View states
    @track showMoviesList = true;
    @track showMovieDetails = false;
    @track showTheaterSelection = false;
    @track showSeatSelection = false;
    @track showBookingConfirmation = false;

    // Sample movie data
    movies = [
        {
            id: 'movie1',
            title: 'Avengers: Endgame',
            genre: 'Action, Adventure, Drama',
            rating: 8.4,
            duration: '3h 1m',
            certificate: 'UA',
            languages: ['English', 'Hindi', 'Tamil'],
            poster: 'https://via.placeholder.com/300x450/FF6B6B/FFFFFF?text=Avengers+Endgame',
            banner: 'https://via.placeholder.com/1200x400/FF6B6B/FFFFFF?text=Avengers+Endgame+Banner',
            description: 'After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos\' actions and restore balance to the universe.'
        },
        {
            id: 'movie2',
            title: 'Spider-Man: No Way Home',
            genre: 'Action, Adventure, Sci-Fi',
            rating: 8.2,
            duration: '2h 28m',
            certificate: 'UA',
            languages: ['English', 'Hindi', 'Telugu'],
            poster: 'https://via.placeholder.com/300x450/4ECDC4/FFFFFF?text=Spider-Man',
            banner: 'https://via.placeholder.com/1200x400/4ECDC4/FFFFFF?text=Spider-Man+Banner',
            description: 'With Spider-Man\'s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.'
        },
        {
            id: 'movie3',
            title: 'The Batman',
            genre: 'Action, Crime, Drama',
            rating: 7.8,
            duration: '2h 56m',
            certificate: 'UA',
            languages: ['English', 'Hindi'],
            poster: 'https://via.placeholder.com/300x450/45B7D1/FFFFFF?text=The+Batman',
            banner: 'https://via.placeholder.com/1200x400/45B7D1/FFFFFF?text=The+Batman+Banner',
            description: 'When the Riddler, a sadistic serial killer, begins murdering key political figures in Gotham, Batman is forced to investigate the city\'s hidden corruption and question his family\'s involvement.'
        },
        {
            id: 'movie4',
            title: 'RRR',
            genre: 'Action, Drama, History',
            rating: 8.0,
            duration: '3h 7m',
            certificate: 'UA',
            languages: ['Telugu', 'Hindi', 'Tamil', 'English'],
            poster: 'https://via.placeholder.com/300x450/F7931E/FFFFFF?text=RRR',
            banner: 'https://via.placeholder.com/1200x400/F7931E/FFFFFF?text=RRR+Banner',
            description: 'A fictitious story about two legendary revolutionaries and their journey away from home before they started fighting for their country in 1920s.'
        },
        {
            id: 'movie5',
            title: 'Top Gun: Maverick',
            genre: 'Action, Drama',
            rating: 8.3,
            duration: '2h 11m',
            certificate: 'UA',
            languages: ['English', 'Hindi'],
            poster: 'https://via.placeholder.com/300x450/96CEB4/FFFFFF?text=Top+Gun',
            banner: 'https://via.placeholder.com/1200x400/96CEB4/FFFFFF?text=Top+Gun+Banner',
            description: 'After thirty years, Maverick is still pushing the envelope as a top naval aviator, but must confront ghosts of his past when he leads TOP GUN\'s elite graduates on a mission that demands the ultimate sacrifice.'
        },
        {
            id: 'movie6',
            title: 'Doctor Strange 2',
            genre: 'Action, Adventure, Fantasy',
            rating: 6.9,
            duration: '2h 6m',
            certificate: 'UA',
            languages: ['English', 'Hindi', 'Tamil', 'Telugu'],
            poster: 'https://via.placeholder.com/300x450/FFEAA7/333333?text=Doctor+Strange',
            banner: 'https://via.placeholder.com/1200x400/FFEAA7/333333?text=Doctor+Strange+Banner',
            description: 'Doctor Strange teams up with a mysterious teenage girl who can travel across multiverses, to battle other-universe versions of himself which threaten to wipe out the multiverse.'
        }
    ];

    // Sample theater data
    theaters = [
        {
            id: 'theater1',
            name: 'PVR Phoenix MarketCity',
            location: 'Kurla, Mumbai',
            amenities: ['Dolby Atmos', 'Recliner', 'Food Court'],
            showTimes: [
                { id: 'show1', time: '10:30 AM', type: '2D', price: 200 },
                { id: 'show2', time: '02:15 PM', type: '3D', price: 300 },
                { id: 'show3', time: '06:00 PM', type: '2D', price: 250 },
                { id: 'show4', time: '09:45 PM', type: '3D', price: 350 }
            ]
        },
        {
            id: 'theater2',
            name: 'INOX Megaplex',
            location: 'Inorbit Mall, Malad',
            amenities: ['IMAX', 'Premium', 'Parking'],
            showTimes: [
                { id: 'show5', time: '11:00 AM', type: 'IMAX', price: 450 },
                { id: 'show6', time: '03:30 PM', type: '2D', price: 220 },
                { id: 'show7', time: '07:15 PM', type: 'IMAX', price: 500 },
                { id: 'show8', time: '10:30 PM', type: '2D', price: 280 }
            ]
        },
        {
            id: 'theater3',
            name: 'Cinepolis Fun Cinemas',
            location: 'Andheri East',
            amenities: ['4DX', 'VIP', 'Food & Beverages'],
            showTimes: [
                { id: 'show9', time: '12:00 PM', type: '4DX', price: 600 },
                { id: 'show10', time: '04:00 PM', type: '2D', price: 180 },
                { id: 'show11', time: '08:30 PM', type: '4DX', price: 650 },
                { id: 'show12', time: '11:00 PM', type: '2D', price: 200 }
            ]
        }
    ];

    // Options for dropdowns
    get languageOptions() {
        return [
            { label: 'All Languages', value: '' },
            { label: 'English', value: 'English' },
            { label: 'Hindi', value: 'Hindi' },
            { label: 'Tamil', value: 'Tamil' },
            { label: 'Telugu', value: 'Telugu' }
        ];
    }

    get genreOptions() {
        return [
            { label: 'All Genres', value: '' },
            { label: 'Action', value: 'Action' },
            { label: 'Adventure', value: 'Adventure' },
            { label: 'Drama', value: 'Drama' },
            { label: 'Sci-Fi', value: 'Sci-Fi' },
            { label: 'Crime', value: 'Crime' },
            { label: 'Fantasy', value: 'Fantasy' }
        ];
    }

    // Filter movies based on search, language, and genre
    get filteredMovies() {
        return this.movies.filter(movie => {
            const matchesSearch = !this.searchTerm || 
                movie.title.toLowerCase().includes(this.searchTerm.toLowerCase()) ||
                movie.genre.toLowerCase().includes(this.searchTerm.toLowerCase());
            
            const matchesLanguage = !this.selectedLanguage || 
                movie.languages.includes(this.selectedLanguage);
            
            const matchesGenre = !this.selectedGenre || 
                movie.genre.toLowerCase().includes(this.selectedGenre.toLowerCase());
            
            return matchesSearch && matchesLanguage && matchesGenre;
        });
    }

    // Generate available dates (next 7 days)
    get availableDates() {
        const dates = [];
        const today = new Date();
        
        for (let i = 0; i < 7; i++) {
            const date = new Date(today);
            date.setDate(today.getDate() + i);
            
            const dayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
            const monthNames = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
            
            dates.push({
                value: date.toISOString().split('T')[0],
                day: dayNames[date.getDay()],
                date: `${date.getDate()} ${monthNames[date.getMonth()]}`,
                cssClass: i === 0 ? 'date-tab active' : 'date-tab'
            });
        }
        
        this.selectedDate = dates[0].value; // Default to today
        return dates;
    }

    // Generate seat layout
    get seatLayout() {
        const rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
        const seatsPerRow = 14;
        const layout = [];
        
        rows.forEach(rowName => {
            const seats = [];
            for (let i = 1; i <= seatsPerRow; i++) {
                const seatId = `${rowName}${i}`;
                const isBooked = Math.random() < 0.3; // 30% seats randomly booked
                const isSelected = this.selectedSeats.some(seat => seat.id === seatId);
                
                seats.push({
                    id: seatId,
                    rowName: rowName,
                    number: i,
                    isBooked: isBooked,
                    isSelected: isSelected,
                    cssClass: isBooked ? 'seat booked' : (isSelected ? 'seat selected' : 'seat available')
                });
            }
            
            layout.push({
                rowName: rowName,
                seats: seats
            });
        });
        
        return layout;
    }

    // Event Handlers
    handleSearch(event) {
        this.searchTerm = event.target.value;
    }

    handleLanguageChange(event) {
        this.selectedLanguage = event.target.value;
    }

    handleGenreChange(event) {
        this.selectedGenre = event.target.value;
    }

    handleMovieClick(event) {
        const movieId = event.currentTarget.dataset.movieId;
        this.selectedMovie = this.movies.find(movie => movie.id === movieId);
        this.showMoviesList = false;
        this.showMovieDetails = true;
    }

    handleBookTickets() {
        this.showMovieDetails = false;
        this.showTheaterSelection = true;
    }

    handleBackToMovies() {
        this.showMovieDetails = false;
        this.showMoviesList = true;
        this.selectedMovie = null;
    }

    handleBackToMovieDetails() {
        this.showTheaterSelection = false;
        this.showMovieDetails = true;
    }

    handleDateSelect(event) {
        this.selectedDate = event.currentTarget.dataset.date;
        
        // Update CSS classes for date tabs
        const dateTabs = this.template.querySelectorAll('.date-tab');
        dateTabs.forEach(tab => {
            tab.classList.remove('active');
        });
        event.currentTarget.classList.add('active');
    }

    handleShowTimeSelect(event) {
        const theaterId = event.currentTarget.dataset.theaterId;
        const showTimeId = event.currentTarget.dataset.showtimeId;
        
        this.selectedTheater = this.theaters.find(theater => theater.id === theaterId);
        this.selectedShowTime = this.selectedTheater.showTimes.find(show => show.id === showTimeId);
        
        this.showTheaterSelection = false;
        this.showSeatSelection = true;
    }

    handleBackToTheaters() {
        this.showSeatSelection = false;
        this.showTheaterSelection = true;
        this.selectedSeats = [];
        this.totalAmount = 0;
    }

    handleSeatSelect(event) {
        const seatId = event.currentTarget.dataset.seatId;
        const seatButton = event.currentTarget;
        
        if (seatButton.disabled) return;
        
        const existingSeatIndex = this.selectedSeats.findIndex(seat => seat.id === seatId);
        
        if (existingSeatIndex > -1) {
            // Deselect seat
            this.selectedSeats.splice(existingSeatIndex, 1);
            seatButton.classList.remove('selected');
            seatButton.classList.add('available');
        } else {
            // Select seat (max 10 seats)
            if (this.selectedSeats.length < 10) {
                const rowName = seatId.charAt(0);
                const seatNumber = seatId.substring(1);
                
                this.selectedSeats.push({
                    id: seatId,
                    rowName: rowName,
                    number: seatNumber
                });
                
                seatButton.classList.remove('available');
                seatButton.classList.add('selected');
            }
        }
        
        this.calculateTotalAmount();
    }

    calculateTotalAmount() {
        this.totalAmount = this.selectedSeats.length * this.selectedShowTime.price;
    }

    handlePayment() {
        // Generate booking ID
        this.bookingId = 'BMS' + Date.now().toString().slice(-8);
        
        // Mark selected seats as the last seat for comma separation
        this.selectedSeats = this.selectedSeats.map((seat, index) => ({
            ...seat,
            isLast: index === this.selectedSeats.length - 1
        }));
        
        this.showSeatSelection = false;
        this.showBookingConfirmation = true;
    }

    handleDownloadTicket() {
        // In a real implementation, this would generate and download a PDF ticket
        alert('Ticket downloaded successfully!');
    }

    handleBookAnother() {
        // Reset all states
        this.selectedMovie = null;
        this.selectedTheater = null;
        this.selectedShowTime = null;
        this.selectedSeats = [];
        this.totalAmount = 0;
        this.bookingId = '';
        
        this.showBookingConfirmation = false;
        this.showMoviesList = true;
    }

    // Initialize component
    connectedCallback() {
        // Set default date to today
        this.selectedDate = new Date().toISOString().split('T')[0];
    }
} 