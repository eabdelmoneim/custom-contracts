// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.4;

import "@thirdweb-dev/contracts/drop/DropERC721.sol";

contract ERC721withAsciiArt is DropERC721 {
    /*
    *                                                                                                                                                                                                         
                                                                                                                                                                                                        
                                                                                                                                                                                                        
                                                                              @@@@(                                                                                                                     
                                                                            @@@@@@@@@@                                                                                                                  
                                                                         @@@@@@@@@@@@@@@                                                                                                                
                                                                         @@@@@@@@@@@@@@@@@                                                                                                              
                   (@@@@@@@@@@@@@@@@                                    @@@@@@@@@@@@@@@@@@                                                                                                              
                @@@@@@@@@@@@@@@@@@@@@@@@                                 @@@@@@@@@@@@@@@@@                                                                                                              
             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                @@@@@@@@@@@@@@@                @@@@@@@@@@@@@@           (((                               (@@@@@@@@@@@@@@@@(                  
           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                 @@@@@@@@@@                @@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@                   @@@@@@@@@@@@@@@@@@@@@@@@@@@              
          @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                            @@@@@@@@@@    @@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@(            (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            
         @@@@@@@@@@@@@@@@@@@@@@@    @@@@@@@@@@                                         @@@@@@@@@@@@@@@  @@@@@@@@@@@@     @@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           
        @@@@@@@@@@@@@@@@@@@@           @@@@@@@@          @@@@@@@@@@(                  @@@@@@@@@@@@@@@@@@ @@@@@@@@@@     @@@@@@@@@@@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          
       @@@@@@@@@@@@@@@@@@@              @@@@@@@@      @@@@@@@@@@@@@@@@                 @@@@@@@@@@@@@@@@@@  @@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           
       @@@@@@@@@@@@@@@@@@               @@@@@@@@     @@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@ @@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@          (@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             
       @@@@@@@@@@@@@@@@@@                @@@@@@@     @@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@  @@@@@@@@@@@@    @@@@@@@@    @@@@@@@@@@@@@     @@@@@@@@@@@@@@@@@@@@                          
       @@@@@@@@@@@@@@@@@@                @@@@@@@     (@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@   @@@@@@@@@@@@@@   @@@@@@@@@   @@@@@@@@@@@@@@@  @@@@@@@@@        @@@@@@@@@@@@@@@@@@@(                         
       @@@@@@@@@@@@@@@@@@                @@@@@@@       @@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@     @@@@@@@@@@@@@  @@@@@@@@@  @@@@@@@@@@@@@@@@@@@                 @@@@@@@@@@  @@@@@@@@@@@@                     
        @@@@@@@@@@@@@@@@@@               @@@@@@@        @@@@@@@@@@@@@@     @@@@@@@@@@@@       (@@@@@@@@@@   @@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@               @@@@@@@@@@      (@@@@@                       
         @@@@@@@@@@@@@@@@@@              @@@@@@@         @@@@@@@@@@@@@@  @@@@@@@@@@@@@         @@@@@@@@@   @@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@              @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            
          @@@@@@@@@@@@@@@@@@@(           @@@@@@@@        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      (@@@@@@@@( @@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         
            @@@@@@@@@@@@@@@@@@@@@@@@      @@@@@@@@       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@ @@@@@@@@@@@@@@@  @@@@@@@@@@@@@@     @@@@@@     @@@@@@@@@@@@@@@        @@@@@@@@@@@@@@@@@@@@@@       
              @@@@@@@@@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@   @@@@@@@@@@@@        @@@@@@    @@@@@@@@@@@@@           @@@@@@@@@@@@@@@@@@@@@      
                 @@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@    @@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@             @@@@@@@@@@@@@@@@@@@@@      
                       (@((           @@@@@@@@ (@@@@@@(@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     @@@@   @@@@@@@@@@@@@@@@@@      @@@@@@@@@         (@@@@@@@@@@@@@@@@@@              @@@@@@@@@@@@@@@@@@@@@      
                                       @@@@@@@@@       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     @@@@@  @@@@@@@@@@@@@@@@           @@@@@@@          @@@@@@@@@@@@@@                @@@@@@@@@@@@@@@@@@@@@       
                                      @@@@@@@@@@@       @@@@@@@@@@@(    @@@@@@@@@   @@@@@   @@@@@   @@@@@@@@@@@@               @@@@@@                                     @@@@@@@@@@@@@@@@@@@@@@        
                  @@@@@            @@@@@@@@@@@@@@@      @@@@@@@@@@@       @@@@@      @@@@@@@   @@@@@@                           @@@@@@           @@@@@@@@@           @@@@@@@@@@@@@@@@@@@@@@@@@@         
             (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    (@@@@@@@@@@@       @@@@@     @@@@@@@@@@     @@@@@@@@@@@@@@@@@@@@@@(       @@@@@@(        @@@@@@@@@@@     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          
            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@     @@@@@@@@@  @@@@@@@@@@@        @@@@@@@@@@@@@@@@@@@@@@@    @@@@@@@@       @@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           
            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@@@@@@   @@@@@@@@@@@@         (@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@(  @@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             
            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@@@@@  @@@@@@@@@@@@   @@@@@@@@@@@@@@@@       @@@@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@@               
            (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(       @@@@@@@@@@@@@@@@  @@@@@@@@@@@    @@@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@(   @@@@@@@@@@@@@@@@@@@@@@@@@@                 
              @@@@@@@@@@@@@@@@@@@@@@@@@@@@             @@@@@@@@@@@@@@    @@@@@@@@@     @@@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@@@@@@@@@@@                    
                 (@@@@@@@@@@@@@@@@@@                     @@@@@@@@@@(        (@(         @@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@(    @@@@@@@@@@@@@@@@@@(       (@@@@@@@@@@@@@@@@@                       
                                                                                           @@@@@@@@@@@@@@        @@@@@@@@@@@@@@        @@@@@@@@@@@@@@@             @@@@@@@@@                            
                                                                                                                   (@@@@@@@@             (@@@@@@@@@                                                     
                                                                                                                                                                                                        
                                                                                                                                                                                                        
    */
}