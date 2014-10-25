## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()  ) {

  m <- NULL                                ## create an empty variable m in the parent 
                                           ## environment (i.e. the makeCacheMatrix function)


                                           ## Next are four small functions within the main makeCacheMatrix function
                                      
                                           
          set <- function(y) {             ## the set function could be used for manually setting a new matrix.
          x <<- y                          ## I think this function could be omitted.
          m <<- NULL                       ## All things within this function are in a child environment
          }


          get <- function()  {             ## The get function gets the input matrix 
          x
          }                                ## All things within this function are in a child environment


          setmatrix <- function(matrix) {  ## The setmatrix function enters the inversed matrix into the m variable in the 
          m <<- matrix                     ## parent environment (hence the double arrow <<- )
          }                                ## All things within this function are in a child environment


          getmatrix <- function()  {       ## The get function tries to retrieve the m variable from its own environment.
          m                                ## It won't find one, and so it retrieves the m from the parent environment.
          }                                ## All things within this function are in a child environment


  
  list(set = set,                          ## this list (in the parent environment)
       get = get,
       setmatrix = setmatrix, 
       getmatrix = getmatrix)

}




## Write a short comment describing this function

cacheSolve <- function(x, ...) {

        m <- x$getmatrix()                 ## m is retrieved from makeCacheMatrix's parent environment...

               if(!is.null(m)) {                          ## ... , if *not* NULL (i.e. an inversed matrix is available), then
                       message("getting cached data")     ## this stored inverted matrix is returned. In addition a message is printed
                       return(m)
               }

        data <- x$get()                                   ## If m in the parent environment *is* NULL, then the inversed matrix is computed, ...
        m <- solve(data, ...)                             ##
        x$setmatrix(m)                                    ## ... passed to the cache for future reference ...

        m                                                 ## and finally printed
}





## now let's run the functions

x <- c( 45 , 75 , 24 , 84 ,4 ,5 ,6 ,7 ,87 )    ## first define a numeric vector with length 4 , or 9 , or 16, or 25, ...
x <- matrix(x ,  sqrt(length(x)) )             ## create a square matrix from this vector
x                                              ## print the matrix, just to check



y <- makeCacheMatrix(x)                        ## call function makeCacheMatrix with matrix x as argument
cacheSolve (y)                                 ## call function cacheSolve with y as argument



                                               ## an extra check;
z <- cacheSolve (y)                            ## 1/ store the inversed matrix in variable z
q <- makeCacheMatrix(z)                        ## 2/ now enter the inversed matrix z as the input matrix into function makeCacheMatrix
cacheSolve(q)                                  ## 3/ print the "inversed inverse matrix q" to check whether we get the origina;l matrix again


